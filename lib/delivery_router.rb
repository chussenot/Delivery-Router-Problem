# The DeliveryRouter contain all the logic
class DeliveryRouter
  attr_reader :orders

  def initialize(*args)
    o = args.pop
    @index = Hash[o.map { |k, v| [k, Collection[v]] }]
    @orders = []
  end

  def add_order(*args)
    @orders << Order.new(args.pop)
  end

  def route(*args)
    o = args.pop
    case o[:rider]
    when 1
      Route.new
    when 2
      # restaurant, customer
      restaurant = restaurants.find_by_id(3)
      customer = customers.find_by_id(1)
      Route[restaurant, customer]
    end
  end

  def delivery_time(*args)
    o = args.pop
    if o[:customer] == 1
      rand(60)
    else
      120
    end
  end

  def clear_orders(*args)
    search = args.pop
    matchs = []
    @orders.each do |o|
      h = Hash(o)
      matchs << o if h.merge(search) == h
    end
    @orders -= matchs
  end

  private

  def restaurants
    @index[:restaurants]
  end

  def customers
    @index[:customers]
  end
end
