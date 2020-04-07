# frozen_string_literal: true

require "test_helper"

class PagSeguro::SubscriptionsTest < Minitest::Test
  def setup
    @client = PagSeguro::Client.new
  end

  def test_charge_subscription
    response = VCR.use_cassette "pre-approvals-charge" do
      @client.subscriptions.create json_fixture(:create)
    end

    assert_equal "E24379924040D85774131F98BC233AF9", response.code
  end

  def test_change_payment_method
    code = "321D3A1AAFAF316CC4E51F8DE0D31D2F"
    response = VCR.use_cassette "pre-approvals-change-payment-method" do
      @client.subscriptions.update code, json_fixture(:update)
    end

    assert_empty response
  end

  def test_generate_checkout_link
    code = "321D3A1AAFAF316CC4E51F8DE0D31D2F"
    url = @client.subscriptions.url(code)

    assert_equal "https://sandbox.pagseguro.uol.com.br/v2/pre-approvals/request.html?code=#{code}", url
  end
end
