# Matches journey times with a Rider-Order couple
class Matching
  attr_accessor :time
  attr_accessor :rider
  attr_accessor :order

  def initialize(**options)
    @rider = options[:rider]
    @time = options[:time]
    @order = options[:order]
  end
end
