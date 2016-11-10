module Np
  class DetermineMatchings < Operation
    def setup_params!(params)
      @solutions = params[:solutions]
    end

    def process(params)
      params[:matchings] = nil
      params
    end
  end
end
