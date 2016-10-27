class Customer
  include Point::InstanceMethods
  attr_accessor :id, :collection
  def initialize(options = nil)
    @id = options[:id]
    @x = options[:x]
    @y = options[:y]
  end

  # @return [Hash] Converts options object to an options hash. All keys
  #   will be symbolized.
  def to_hash
    { id: id, x: x, y: y }
  end

  alias to_h to_hash
end
