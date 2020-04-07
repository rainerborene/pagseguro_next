# frozen_string_literal: true

require "test_helper"

class PagSeguro::PaymentOrdersTest < Minitest::Test
  def setup
    @client = PagSeguro::Client.new
  end

  def test_list_all_orders
    response = VCR.use_cassette "pre-approvals-payment-orders" do
      @client.payment_orders.fetch("CF0FF9773A3A75266463EFACE34F89EC")
    end

    payment_order = response.first

    assert_equal 1, response.length
    assert_not_nil payment_order.amount
    assert_not_nil payment_order.last_event_date
    assert_not_nil payment_order.scheduling_date
  end
end
