# The DeliveryRouter contain all the logic
# to drive dumb riders
class DeliveryRouter
  class Configuration
    attr_accessor :steps

    def initialize
      @steps = [
        TimeToRestaurant,
        BestRider,
        RideTotalDuration
      ]
    end
  end

  class << self
    attr_writer :config
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.reset
    @config = Configuration.new
  end

  def self.configure
    yield(config)
  end

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
    s?[:routes][rider] || []
  end

  def delivery_time(**options)
    options.symbolize_keys!
    s?[:delivery_times][options[:customer]]
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

  def s?
    @solution ||= Hash.new { |h, k| h[k] = {} }
  end

  def update!(method = :last)
    params = { riders: riders }
    @solution = nil if method == :all # reset solution hash
    params[:orders] = method == :all ? @orders : [@orders.last]
    DeliveryRouter.config.steps.each do |operation|
      ok, params = operation.run(params)
      raise 'Bad operation process' unless ok
    end
    # Assign
    params[:winners].each.with_index do |winner, index|
      _t, rider, order = winner
      s?[:routes][rider.id] = order.to_a
      s?[:delivery_times][order.customer.id] = params[:times][index]
    end
  end
end
