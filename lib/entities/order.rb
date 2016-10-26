class Order
  attr_accessor :customer, :restaurant, :collection
  def initialize(attributes)
    @customer = attributes[:customer]
    @restaurant = attributes[:restaurant]
  end

  def to_hash
    { customer: customer, restaurant: restaurant }
  end

  alias to_h to_hash
end
