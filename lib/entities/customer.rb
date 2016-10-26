class Customer
  include Point::InstanceMethods
  attr_accessor :id, :collection
  def initialize(attributes = nil)
    @id = attributes[:id]
    @x = attributes[:x]
    @y = attributes[:y]
  end

  def to_hash
    { id: id, x: x, y: y }
  end

  alias to_h to_hash
end
