# frozen_string_literal: true

require "test_helper"

class PagSeguro::CheckoutTest < Minitest::Test
  def setup
    @client = PagSeguro::Client.new app: true, authorization_code: "06599FEFB7074C2E892972EE35DFCC9B"
  end

  def test_creates_a_checkout_for_customer
    resp = VCR.use_cassette "checkout" do
      @client.checkout.create(
        id: "10",
        description: "VideoMaker Academy",
        amount: 197.0
      )
    end

    assert_equal 32, resp.code.size
    assert_not_nil resp.date
  end
end
