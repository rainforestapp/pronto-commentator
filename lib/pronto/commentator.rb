# frozen_string_literal: true
require 'pronto'
require 'yaml'

module Pronto
  class Commentator < Runner
    class ConfigError < StandardError; end

    CONFIG_DIR = '.commentator'

    def run
      return [] unless config && file_patches
      return ConfigError, "Commentator config does not contain the 'files' key" unless config['files'].is_a? Hash

      file_patches.flat_map do |patch|
        config.fetch('files').map do |pattern, msg_file|
          if File.fnmatch? pattern, patch.delta.new_file[:path], File::FNM_PATHNAME
            new_message patch, msg_file
          end
        end.compact
      end
    end

    private

    def file_patches
      @file_patches ||=
        @patches.select { |patch| patch.additions > 0 }
        .uniq(&:new_file_full_path)
    end

    def new_message(patch, msg_file)
      msg = File.read File.join(CONFIG_DIR, msg_file)

      Message.new(patch.delta.new_file[:path], patch.added_lines.first, :info, msg)
    rescue Errno::ENOENT
      raise ConfigError, "#{msg_file} does not exist in the commentator config dir."
    end

    def repo_path
      file_patches.first.repo.path
    end

    def config
      conf_file = File.join CONFIG_DIR, 'config.yml'

      @commentator_config ||= YAML.load(File.read(conf_file))
    rescue Errno::ENOENT
      nil
    end
  end
end
