# Eating establishment where we prepare meals
# This restaurant serves good food!
class Restaurant
  include Point::InstanceMethods
  attr_accessor :id, :cooking_time, :collection
  def initialize(options)
    @id = options[:id]
    @x = options[:x]
    @y = options[:y]
    @cooking_time = options[:cooking_time]
  end

  # @return [Hash] Converts options object to an options hash. All keys
  #   will be symbolized.
  def to_hash
    { id: id, x: x, y: y, cooking_time: cooking_time }
  end

  alias to_h to_hash
end
