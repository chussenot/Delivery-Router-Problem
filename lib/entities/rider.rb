# Riders are ninjas!
class Rider < Entity
  attr_accessor :speed
  def initialize(options)
    super(options)
    @speed = options[:speed]
  end

  # @return [Boolean] whether another Options object equals the
  #   keys and values of this options object
  def ==(other)
    return true if other.equal?(self)
    return false unless other.instance_of?(self.class)
    (id == other.id && x == other.x && y == other.y && speed == other.speed)
  end

  # @return [Hash] Converts options object to an options hash. All keys
  #   will be symbolized.
  def to_hash
    { speed: speed }.merge!(super)
  end

  alias to_h to_hash
end
