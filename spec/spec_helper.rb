if ENV['COVERAGE']
  Bundler.require(:simplecov)
  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::CSVFormatter,
    SimpleCov::Formatter::CoberturaFormatter,
    SimpleCov::Formatter::JSONFormatter,
    SimpleCov::Formatter::TextFormatter
  ]
  SimpleCov.start do
    add_filter 'spec'
    add_group 'Entities', 'lib/entities'
    add_group 'Operations', 'lib/operations'
  end
end

require './stack'

class SimpleOperation < Operation
  def process(params)
    @valid = false
    (params[:name]).to_s
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
