module Np
  class EvaluateSolutions < Operation
    MAX_TIME = 60.0

    def setup_params!(params)
      @orders = params[:orders]
      @riders = params[:riders]
      params[:solutions] ||= []
      @solutions = params[:solutions]
    end

    def process(params)
      if @orders.size > 0
        order = @orders.pop
        matchs = @riders.to_a.product([order])
        matchs.each do |rider, order|
          time = 60 / rider.speed * rider.distance(order.restaurant)
          time = [time, order.restaurant.cooking_time].max
            + 60 / rider.speed * order.restaurant.distance(order.customer)
          if time <= MAX_TIME
            @solutions << Matching.new(rider: rider, order: order, time: time)
            ok, params = EvaluateSolutions.run(params)
          end
        end
        params
      else
        params
      end
    end
  end
end
