class TimeToRestaurant < Operation
  def setup_params!(params)
    @orders = params[:orders]
    @riders = params[:riders]
  end

  def process(_params)
    @riders.to_a.product(@orders).map do |rider, order|
      60 / rider.speed * rider.distance(order.restaurant)
    end
  end
end
