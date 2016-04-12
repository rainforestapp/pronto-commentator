# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pronto/commentator'

RSpec.shared_context 'test repo' do
  let(:git) { 'spec/fixtures/test.git/git/' }
  let(:dot_git) { 'spec/fixtures/test.git/.git/' }

  before do
    FileUtils.mv(git, dot_git)
    stub_const 'Pronto::Commentator::CONFIG_DIR', 'spec/fixtures/test.git/.commentator'
  end
  let(:repo) { Pronto::Git::Repository.new('spec/fixtures/test.git') }
  after { FileUtils.mv(dot_git, git) }
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
