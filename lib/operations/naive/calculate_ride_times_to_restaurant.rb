# Calculate times taken for all riders to reach any restaurant.
module Naive
  class CalculateRideTimesToRestaurant < Operation
    def setup_params!(params)
      @orders = params[:orders]
      @riders = params[:riders]
    end

    def process(params)
      times = @riders.to_a.product(@orders).map do |rider, order|
        raise Exception, 'order or rider is null' if order.nil? || rider.nil?
        60 / rider.speed * rider.distance(order.restaurant)
      end
      params.merge(times: times)
    end
  end
end
