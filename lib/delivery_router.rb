# The DeliveryRouter contain all the logic
# to drive dumb riders
class DeliveryRouter
  attr_reader :orders

  def initialize(**options)
    options.symbolize_keys!
    @index = Hash[options.map { |k, v| [k, Collection[v]] }]
    @index.keys.each do |key|
      self.class.send(:define_method, key, -> { @index[key] })
    end
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

  def sol
    @solution ||= Hash.new { |h, k| h[k] = {} }
  end

  def update!(method = :last)
    params = { riders: riders }
    @solution = nil if method == :all # reset solution hash
    params[:orders] = method == :all ? @orders : [@orders.last]
    # Times resolution
    ok, times = TimeToRestaurant.run(params)
    params[:times] = times
    # Find the best riders
    ok, winners = BestRider.run(params)
    # Final ride duration
    ok, times = RideTotalDuration.run(winners: winners)
    # Assign
    winners.each.with_index do |winner, index|
      _t, rider, order = winner
      sol[:routes][rider.id] = order.to_a
      sol[:delivery_times][order.customer.id] = times[index]
    end
  end
end
