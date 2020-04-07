# frozen_string_literal: true

module PagSeguro
  class Subscriptions
    include Restful

    def find_by_notification_code(code)
      get("/pre-approvals/notifications/#{code}")
    end

    def create(params)
      params = parameterize params
      post("/pre-approvals", params)
    end

    def update(code, params)
      params = parameterize params
      put("/pre-approvals/#{code}/payment-method", params)
    end

    def url(code)
      url_for :site, "/v2/pre-approvals/request.html", code: code
    end
  end
end
