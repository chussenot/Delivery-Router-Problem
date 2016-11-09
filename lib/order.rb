class Order
  attr_accessor :customer, :restaurant
  def initialize(options)
    @customer = options[:customer]
    @restaurant = options[:restaurant]
  end

  # @return [Hash] Converts options object to an options hash.
  # All keys will be symbolized.
  def to_hash
    { restaurant: restaurant.id, customer: customer.id }
  end

  def to_array
    [restaurant, customer]
  end

  # Inspects the object
  def inspect
    "<#{self.class} #{{ customer: @customer.id, restaurant: @restaurant.id }}>"
  end

  alias to_a to_array
  alias to_h to_hash
end
