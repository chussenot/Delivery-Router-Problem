class BestRider < Operation
  def setup_params!(params)
    @orders = params[:orders]
    @times = params[:times]
    @riders = params[:riders]
  end

  def process(_params)
    @orders.map.with_index do |order, index|
      time_map = Hash.new { |h, k| h[k] = [] }
      @riders.map { |rider| time_map[@times.shift] << rider }
      faster_time, winners = time_map.min_by { |k, _v| k }
      winner = winners[index]
      [faster_time, winner, order]
    end
  end
end
