require "spec_helper"

describe PagSeguro::Subscriptions do
  it "should charge subscription" do
    response = VCR.use_cassette "pre-approvals-charge" do
      api = PagSeguro::API.new
      api.subscriptions.create json(:create)
    end

    response.code.must_equal "E24379924040D85774131F98BC233AF9"
  end

  it "should change payment method" do
    code = "321D3A1AAFAF316CC4E51F8DE0D31D2F"
    response = VCR.use_cassette "pre-approvals-change-payment-method" do
      api = PagSeguro::API.new
      api.subscriptions.update code, json(:update)
    end

    response.must_be(:success?)
  end

  it "should generate checkout link" do
    code = "321D3A1AAFAF316CC4E51F8DE0D31D2F"
    api = PagSeguro::API.new
    url = api.subscriptions.url(code)

    url.must_equal "https://sandbox.pagseguro.uol.com.br/v2/pre-approvals/request.html?code=#{code}"
  end
end
