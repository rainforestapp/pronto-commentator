# frozen_string_literal: true
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/commentator/version'

Gem::Specification.new do |spec|
  spec.name          = 'pronto-commentator'
  spec.version       = Pronto::CommentatorVersion::VERSION
  spec.authors       = ['Emanuel Evans']
  spec.email         = ['emanuel@rainforestqa.com']

  spec.summary       = 'A simple code review tool for Pronto.'
  spec.description   = <<-EOS
    A simple runner for Pronto that adds pre-defined comments based on which files have changed.
  EOS
  spec.homepage      = 'https://github.com/rainforestapp/pronto-commentator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'pronto', '~> 0.6.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec', '~> 4.6.5'
  spec.add_development_dependency 'awesome_print'
end
