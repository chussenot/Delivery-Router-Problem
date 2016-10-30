# The DeliveryRouter contain all the logic
# to drive dumb riders
class DeliveryRouter
  attr_reader :orders

  def initialize(**options)
    options.symbolize_keys!
    @index = Hash[options.map { |k, v| [k, Collection[v]] }]
    @orders = []
  end

  def add_order(**options)
    options.symbolize_keys!
    customer = customers.find_by_id(options[:customer])
    restaurant = restaurants.find_by_id(options[:restaurant])
    @orders << Order.new(customer: customer, restaurant: restaurant)
    update!
  end

  def route(**options)
    options.symbolize_keys!
    rider = options[:rider]
    sol[:routes][rider] || []
  end

  def delivery_time(**options)
    options.symbolize_keys!
    sol[:delivery_times][options[:customer]]
  end

  # Clear every orders
  def clear_orders(**search)
    matchs = []
    @orders.each do |o|
      Hash(o).tap { |h| matchs << o if h.merge(search) == h }
    end
    @orders -= matchs
    update!(:all)
  end

  private

  def restaurants
    @index[:restaurants]
  end

  def customers
    @index[:customers]
  end

  def riders
    @index[:riders]
  end

  def sol
    @solution ||= Hash.new { |h, k| h[k] = {} }
  end

  def update!(method = :last)
    @solution = nil if method == :all # reset solution hash
    a = method == :all ? @orders : [@orders.last]
    # Times resolution
    times = riders.to_a.product(a)
                  .map { |rider, order| ride_to_restaurant(rider, order) }
    # Find the best riders
    fwos = a.map.with_index { |order, index| best_rider(order, times, index) }
    # Final ride duration
    times = fwos.map { |f, w, o| ride_duration(f, w, o) }
    fwos.each.with_index do |fwo, index|
      _f, w, o = fwo
      sol[:routes][w.id] = o.to_a
      sol[:delivery_times][o.customer.id] = times[index]
    end
  end

  def best_rider(order, times, index)
    time_map = Hash.new { |h, k| h[k] = [] }
    riders.map { |rider| time_map[times.shift] << rider }
    faster_time, winners = time_map.min_by { |k, _v| k }
    winner = winners[index]
    [faster_time, winner, order]
  end

  def ride_to_restaurant(rider, order)
    60 / rider.speed * rider.distance(order.restaurant)
  end

  def ride_duration(faster_time, rider, order)
    [faster_time, order.restaurant.cooking_time].max
    + 60 / rider.speed * order.restaurant.distance(order.customer)
  end
end
