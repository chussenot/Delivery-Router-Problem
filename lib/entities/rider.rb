class Rider
  attr_accessor :id, :speed, :x, :y, :collection
  def initialize(attributes)
    @id = attributes[:id]
    @x = attributes[:y]
    @y = attributes[:y]
    @speed = attributes[:speed]
  end

  def to_hash
    { id: id, x: x, y: y, speed: speed }
  end

  alias to_h to_hash
end
