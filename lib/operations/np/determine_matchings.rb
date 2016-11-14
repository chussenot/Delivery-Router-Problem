module Np
  class DetermineMatchings < Operation
    def setup_params!(params)
      @solutions = params[:solutions]
    end

    def process(params)
      matchings = []
      @solutions.each do |match|
        orders = matchings.map(&:order)
        if orders.include?(match.order)
          index = orders.index(match.order)
          if(matchings[index].time > match.time)
            matchings[index] = match
          end
        else
          matchings << match
        end
      end
      params[:matchings] = matchings
      params
    end
  end
end
