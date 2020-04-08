# frozen_string_literal: true

module PagSeguro
  class PaymentOrders
    include Restful

    def fetch(code, params = {})
      response = get("/pre-approvals/#{code}/payment-orders", params, {})
      response.paymentOrders.values || {}
    end
  end
end
