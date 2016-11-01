# Eating establishment where we prepare meals.
# These restaurants serve good food!
class Restaurant < Entity
  attr_accessor :cooking_time
  def initialize(options)
    super(options)
    @cooking_time = options[:cooking_time]
  end

  # @return [Hash] Converts options object to an options hash. All keys
  #   will be symbolized.
  def to_hash
    { cooking_time: cooking_time }.merge!(super)
  end

  alias to_h to_hash
end
