# Allows objects to be identied and positioned.
class Entity
  include Point::InstanceMethods
  attr_reader :id
  attr_accessor :collection
  def initialize(options = {})
    @id = options[:id]
    @x = (options[:x] || options[:lat])
    @y = (options[:y] || options[:lng])
  end

  # @return [Hash] Converts options object to an options hash. All keys
  #   will be symbolized.
  def to_hash
    { id: id, x: x, y: y }
  end

  alias to_h to_hash

  # Inspects the object
  def inspect
    "<#{self.class} #{{ id: @id, x: @x, y: @y }}>"
  end
end
