# The DeliveryRouter contains all the logic
# to drive dumb riders
class DeliveryRouter
  class Configuration
    attr_accessor :steps

    def initialize
      @steps = []
    end
  end

  class << self
    def config
      @config ||= Configuration.new
    end

    def reset
      @config = Configuration.new
    end

    def configure
      yield(config)
    end
  end

  def initialize(**options)
    options.symbolize_keys!
    @index = Hash[options.map { |k, v| [k, Collection[v]] }]
    @index.keys.each do |key|
      self.class.send(:define_method, key, -> { @index[key] })
    end
    @orders = {}
    @solution = Hash.new { |h, k| h[k] = {} }
  end

  def add_order(**options)
    options.symbolize_keys!
    customer = customers.find_by_id(options[:customer])
    restaurant = restaurants.find_by_id(options[:restaurant])
    @orders[customer.id] = Order.new(customer: customer, restaurant: restaurant)
    update!(customer.id)
  end

  def add_orders(**options)
    options.symbolize_keys!
    options[:orders].each do |o|
      customer = customers.find_by_id(o[:customer])
      restaurant = restaurants.find_by_id(o[:restaurant])
      @orders[customer.id] = Order.new(customer: customer, restaurant: restaurant)
    end
    update!
  end

  # Clear every orders
  def clear_orders(**search)
    @orders.delete search[:customer]
    update!
  end

  def route(**options)
    options.symbolize_keys!
    rider = options[:rider]
    s?[:routes][rider] || []
  end

  def delivery_time(**options)
    options.symbolize_keys!
    s?[:delivery_times][options[:customer]]
  end

  private

  def s?
    @solution
  end

  def update!(customer_id = nil)
    params = { riders: riders.clone }
    @solution.clear if customer_id.nil? # reset @solution hash
    params[:orders] = (customer_id.nil? ? @orders.values : [@orders[customer_id]]).clone
    DeliveryRouter.config.steps.each do |operation|
      ok, params = operation.run(params)
      raise 'Bad operation process' unless ok
    end
    assign(params[:matchings])
  end

  # Assign matchings values to the @solution Hash
  # for quick access
  def assign(matchings)
    matchings.each do |match|
      s?[:routes][match.rider.id] = match.order.to_a
      s?[:delivery_times][match.order.customer.id] = match.time
    end unless matchings.nil?
  end
end
