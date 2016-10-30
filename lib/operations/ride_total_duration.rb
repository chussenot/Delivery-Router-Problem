# Final ride duration
class RideTotalDuration < Operation
  def setup_params!(params)
    @winners = params[:winners]
  end

  def process(params)
    times = @winners.map do |time, rider, order|
      [time, order.restaurant.cooking_time].max
      + 60 / rider.speed * order.restaurant.distance(order.customer)
    end
    params[:times] = times
    params
  end
end
