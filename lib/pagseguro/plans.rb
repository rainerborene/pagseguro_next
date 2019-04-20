module PagSeguro
  class Plans < Base
    def create(params)
      params[:amount_per_payment] = to_money params[:amount_per_payment]
      params = parameterize params

      parse_body api.post("/pre-approvals/request", preApproval: params)
    end

    def update(code, params)
      params[:amount_per_payment] = to_money params[:amount_per_payment]
      params = parameterize params

      api.put "/pre-approvals/request/#{code}/payment", params
    end

    private

    def to_money(value)
      format "%.2f", value.to_f
    end
  end
end
