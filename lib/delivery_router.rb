# The DeliveryRouter contain all the logic
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
    solution[:routes][rider] || []
  end

  def delivery_time(**options)
    options.symbolize_keys!
    solution[:delivery_times][options[:customer]]
  end

  # Clear every orders
  def clear_orders(**search)
    matchs = []
    @orders.each do |o|
      h = Hash(o)
      matchs << o if h.merge(search) == h
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

  def update!(method = :last)
    p = proc do |order|
      time_map = Hash.new { |h, k| h[k] = [] }
      riders.map do |rider|
        time = ride_to_restaurant(rider, order)
        time_map[time] << rider
      end
      faster_time, winners = time_map.min_by { |k, _v| k }
      winner = winners.first
      duration = ride_duration(winner, order)
      solution[:routes][winner.id] = order.to_a
      solution[:delivery_times][order.customer.id] = duration
    end
    o = case method
        when :last
          [@orders.last]
        when :all
          @solution = nil # reset solution hash
          @orders
        end
    o.each { |order| p.call(order) }
  end

  def solution
    @solution ||= Hash.new { |h, k| h[k] = {} }
  end

  def ride_to_restaurant(rider, order)
    60 / rider.speed * rider.distance(order.restaurant)
  end

  def ride_duration(rider, order)
    time = [60 / rider.speed * rider.distance(order.restaurant),
            order.restaurant.cooking_time].max
    time += 60 / rider.speed * order.restaurant.distance(order.customer)
  end
end
