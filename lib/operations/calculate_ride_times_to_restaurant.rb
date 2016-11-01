# Calculate times taken for all riders to reach any restaurant.
class CalculateRideTimesToRestaurant < Operation
  def setup_params!(params)
    @orders = params[:orders]
    @riders = params[:riders]
  end

  def process(params)
    times = @riders.to_a.product(@orders).map do |rider, order|
      60 / rider.speed * rider.distance(order.restaurant)
    end
    params.merge(times: times)
  end
end
