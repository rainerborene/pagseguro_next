require "spec_helper"

describe PagSeguro::Subscriptions do
  it "should charge subscription" do
    data = json "pagseguro/create"
    response = VCR.use_cassette "pre-approvals-charge" do
      api = PagSeguro::API.new
      api.subscriptions.create(data)
    end

    response.code.must_equal "E24379924040D85774131F98BC233AF9"
  end

  it "should change payment method" do
    data = json "pagseguro/update"
    code = "321D3A1AAFAF316CC4E51F8DE0D31D2F"
    response = VCR.use_cassette "pre-approvals-change-payment-method" do
      api = PagSeguro::API.new
      api.subscriptions.update code, data
    end

    response.must_be(:success?)
  end
end
