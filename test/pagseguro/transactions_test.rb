# frozen_string_literal: true

require "test_helper"

class PagSeguro::TransactionsTest < Minitest::Test
  def setup
    @client = PagSeguro::Client.new app: true
  end

  def test_find_by_transaction_code
    code = "E561E89F66D244B880199A5CEB2F6055"
    resp = VCR.use_cassette "transactions" do
      @client.transactions.find code
    end

    assert_equal :in_analysis, resp.status
    assert_equal "1", resp.items.item.id
    assert_equal "197.00", resp.items.item.amount
    assert_not_nil resp.sender.email
  end

  def test_find_by_notification_code
    code = "D21159-7338E738E771-2774CCEFBF1F-4B9E98"
    resp = VCR.use_cassette "transactions-notification" do
      @client.transactions.find_by_notification_code code
    end

    assert_equal :paid, resp.status
    assert_equal "ba2bf7ee-60cf-40e2-8e90-200223012c52", resp.items.item.id
    assert_equal "197.00", resp.items.item.amount
    assert_not_nil resp.sender.email
  end

  def test_handle_abandoned_transactions
    code = "F95301-69CA74CA74F2-E334CF9F97DD-689218"
    stub_request(:get, %r{transactions/notifications}).to_return(
      headers: { "Content-Type" => "application/json" },
      body: JSON.generate(json_fixture(:abandoned))
    )

    resp = @client.transactions.find_by_notification_code code
    assert_predicate resp, :error?
  end
end
