require "spec_helper"

describe PagSeguro::Checkout do
  it "creates a checkout for customer" do
    code = "06599FEFB7074C2E892972EE35DFCC9B"
    resp = VCR.use_cassette "checkout" do
      api = PagSeguro::API.new app: true, authorization_code: code
      api.checkout.create(
        id: "10",
        description: "VideoMaker Academy",
        amount: 197.0
      )
    end

    resp.code.size.must_equal 32
    resp.date.wont_be_nil
  end
end
