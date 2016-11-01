# Add total journey duration to Rider-Order matches
class CalculateTotalJourneyTimes < Operation
  def setup_params!(params)
    @matchings = params[:matchings]
  end

  # all stages in the process
  def process(params)
    @matchings.each do |match|
      time = [match.time, match.order.restaurant.cooking_time].max
      + 60 / match.rider.speed * match.order.restaurant.distance(match.order.customer)
      match.time = time
    end
    params
  end
end
