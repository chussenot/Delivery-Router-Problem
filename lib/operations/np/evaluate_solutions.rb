module Np
  class EvaluateSolutions < Operation
    def setup_params!(params)
      @orders = params[:orders]
      @riders = params[:riders]
      params[:solutions] ||= {}
      @solutions = params[:solutions]
    end

    def process(params)
      if @orders.size > 0
        @orders.pop
        ok, params = EvaluateSolutions.run(params)
        params
      else
        params
      end
    end
  end
end
