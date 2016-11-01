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
    @orders = []
    @solution = Hash.new { |h, k| h[k] = {} }
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
    @solution
  end

  def update!(method = :last)
    params = { riders: riders }
    @solution.clear if method == :all # reset @solution hash
    params[:orders] = method == :all ? @orders : [@orders.last]
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
