class Customer
  attr_accessor :id, :x, :y, :collection
  def initialize(attributes = nil)
    @id = attributes[:id]
    @x = attributes[:y]
    @y = attributes[:y]
  end

  def to_hash
    { id: id, x: x, y: y }
  end

  alias to_h to_hash
end
