# Eating establishment where we prepare meals
# This restaurant serves good food!
class Restaurant < Entity
  attr_accessor :cooking_time
  def initialize(options)
    super(options)
    @cooking_time = options[:cooking_time]
  end

  # @return [Hash] Converts options object to an options hash. All keys
  #   will be symbolized.
  def to_hash
    super.merge(cooking_time: cooking_time)
  end
end
