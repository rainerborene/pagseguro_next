require "spec_helper"

describe PagSeguro::PaymentOrders do
  it "should list all orders" do
    code = "CF0FF9773A3A75266463EFACE34F89EC"
    response = VCR.use_cassette "pre-approvals-payment-orders" do
      api = PagSeguro::API.new
      api.payment_orders.fetch code
    end

    payment_order = response.first

    response.length.must_equal 1
    payment_order.amount.wont_be_nil
    payment_order.last_event_date.wont_be_nil
    payment_order.scheduling_date.wont_be_nil
  end
end
