# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Pronto::Commentator do
  let(:commentator) { described_class.new patches }

  describe '#run' do
    subject { commentator.run }

    context 'with nil patches' do
      let(:patches) { nil }

      it { is_expected.to eq [] }
    end

    context 'with no patches' do
      let(:patches) { [] }

      it { is_expected.to eq [] }
    end

    context 'with patches' do
      include_context 'test repo'

      let(:patches) { repo.diff('master') }

      it 'includes messages for changed files according to the config' do
        expect(subject.count).to eq 4

        { 'a' => 2, 'z' => 1, 'nothing' => 0, 'dir/foo/bar/baz/qux' => 1 }.each do |path, count|
          expect(subject.count { |msg| msg.path == path }).to eq count
        end

        as = subject.select { |msg| msg.path == 'a' }
        expect(as.map { |msg| msg.msg.strip }.sort).to eq ['A', 'SINGLE LETTER']
      end
    end
  end
end
