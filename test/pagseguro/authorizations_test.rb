# frozen_string_literal: true

require "test_helper"

class PagSeguro::AuthorizationsTest < Minitest::Test
  def setup
    @client = PagSeguro::Client.new app: true
  end

  def test_request_a_new_authorization_code
    auth = VCR.use_cassette "authorizations" do
      @client.authorizations.create(
        redirect_url: "http://localtest.me:3000",
        permissions: [
          :receive_transaction_notifications,
          :search_transactions
        ]
      )
    end

    assert_equal 32, auth.code.size
    assert_not_nil auth.date
  end

  def test_fetch_account_details_from_authorization_code
    code = "DFDCD4FB76297629A9E224861F89EB59E287"
    auth = VCR.use_cassette "authorizations-code" do
      @client.authorizations.find_by_notification_code(code)
    end

    assert_equal 32, auth.code.size
    assert_not_nil auth.authorizer_email
    assert_not_nil auth.account.public_key
  end
end
