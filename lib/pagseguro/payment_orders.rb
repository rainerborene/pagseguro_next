module PagSeguro
  class PaymentOrders < Base
    class Item < Hashie::Dash
      include Hashie::Extensions::Dash::PropertyTranslation
      include Hashie::Extensions::IgnoreUndeclared
      include Hashie::Extensions::IndifferentAccess

      property :amount, transform_with: ->(value) { format "R$%.2f", value }
      property :scheduling_date, from: :schedulingDate, transform_with: ->(value) { value.to_date }
      property :last_event_date, from: :lastEventDate, transform_with: ->(value) { value.to_date }
    end

    def fetch(code, params = {})
      params.reverse_merge! status: 5, page: 0
      response = api.get("/pre-approvals/#{code}/payment-orders", params)
      orders = response.body["paymentOrders"] || {}
      orders.values.map { |item| Item.new item }
    end
  end
end
