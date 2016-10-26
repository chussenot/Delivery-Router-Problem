class Rider
  include Point::InstanceMethods
  attr_accessor :id, :speed, :collection
  def initialize(attributes)
    @id = attributes[:id]
    @x = attributes[:x]
    @y = attributes[:y]
    @speed = attributes[:speed]
  end

  def to_hash
    { id: id, x: x, y: y, speed: speed }
  end

  alias to_h to_hash
end
