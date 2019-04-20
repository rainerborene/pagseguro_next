require "spec_helper"

describe PagSeguro::Authorizations do
  it "should request a new authorization code" do
    auth = VCR.use_cassette "authorizations" do
      api = PagSeguro::API.new app: true
      api.authorizations.create(
        redirect_url: "http://localtest.me:3000",
        permissions: [
          :receive_transaction_notifications,
          :search_transactions
        ]
      )
    end

    auth.code.size.must_equal 32
    auth.date.wont_be_nil
  end

  it "should fetch account details from authorization code" do
    code = "DFDCD4FB76297629A9E224861F89EB59E287"
    auth = VCR.use_cassette "authorizations-code" do
      api = PagSeguro::API.new app: true
      api.authorizations.find_by_notification_code(code)
    end

    auth.code.size.must_equal 32
    auth.authorizer_email.wont_be_nil
    auth.account.public_key.wont_be_nil
  end
end
