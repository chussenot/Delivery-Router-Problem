Bundler.require :default
require 'ostruct'

class DeliveryRouter < Struct.new(:id, :x, :y)

  def add_order(*args)
  end

  def route(*args)
    []
  end

  def delivery_time(*args)
    1
  end

  def clear_orders(*args)
  end
end

class Customer < Struct.new(:id, :x, :y)
end

class Restaurant < Struct.new(:id, :cooking_time, :x, :y)
end

class Rider < Struct.new(:id, :speed, :x, :y)
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
