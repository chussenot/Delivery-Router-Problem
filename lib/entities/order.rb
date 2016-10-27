class Order
  attr_accessor :customer, :restaurant, :collection
  def initialize(attributes)
    @customer = attributes[:customer]
    @restaurant = attributes[:restaurant]
  end

  def to_hash
    { customer: customer.id, restaurant: restaurant.id }
  end

  alias to_h to_hash
end
