# Find optimum matches for Riders and Orders based on Rider times
class MatchRidersWithOrders < Operation
  def setup_params!(params)
    @times = params[:times]
    @orders = params[:orders]
    @riders = params[:riders]
    @time_map = Hash.new { |h, k| h[k] = [] }
  end

  def process(params)
    matchings = @orders.map.with_index do |order, index|
      @time_map.clear
      @riders.map { |rider| @time_map[@times.shift] << rider }
      faster_time, riders = @time_map.min_by { |k, _v| k }
      Matching.new(time: faster_time, rider: riders[index], order: order)
    end
    params.merge(matchings: matchings)
  end
end
