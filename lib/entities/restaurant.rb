class Restaurant
  attr_accessor :id, :cooking_time, :x, :y, :collection
  def initialize(attributes)
    @id = attributes[:id]
    @x = attributes[:y]
    @y = attributes[:y]
    @cooking_time = attributes[:cooking_time]
  end

  def to_hash
    { id: id, x: x, y: y, cooking_time: cooking_time }
  end

  alias to_h to_hash
end
