require 'uber/builder'

class Operation
  include Uber::Builder

  class << self
    def run(*params) # Endpoint behaviour
      res, op = build_operation_class(*params).new.run(*params)
      if block_given?
        yield op if res
        return op
      end
      [res, op]
    end

    def call(*params)
      build_operation_class(*params).new.run(*params).last
    end

    alias [] call

    private

    def build_operation_class(*params)
      # Uber::Builder::class_builder
      class_builder.call(*params)
    end
  end

  def initialize(_options = {})
    @valid = true
  end

  def run(*params)
    setup!(*params)
    [process(*params), valid?].reverse
  end

  def valid?
    @valid
  end

  private

  def setup!(*params)
    setup_params!(*params)
    setup_default!(*params)
  end

  # Override to add attributes that can be infered from params.
  def setup_params!(*params)
  end

  def setup_default!(*params)
  end
end
