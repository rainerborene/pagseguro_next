module PagSeguro
  class Subscriptions < Base
    def find_by_notification_code(code)
      parse_body api.get("/pre-approvals/notifications/#{code}")
    end

    def create(params)
      params = parameterize params

      parse_body api.post("/pre-approvals", params)
    end

    def update(code, params)
      params = parameterize params

      api.put("/pre-approvals/#{code}/payment-method", params)
    end
  end
end
