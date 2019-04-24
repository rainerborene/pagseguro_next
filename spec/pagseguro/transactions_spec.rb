require "spec_helper"

describe PagSeguro::Transactions do
  it "find by transaction code" do
    code = "E561E89F66D244B880199A5CEB2F6055"
    resp = VCR.use_cassette "transactions" do
      api = PagSeguro::API.new app: true
      api.transactions.find code
    end

    resp.status.must_equal :in_analysis
    resp.items.item.id.must_equal "1"
    resp.items.item.amount.must_equal "197.00"
    resp.sender.email.wont_be_nil
  end

  it "find by notification code" do
    code = "D21159-7338E738E771-2774CCEFBF1F-4B9E98"
    resp = VCR.use_cassette "transactions-notification" do
      api = PagSeguro::API.new app: true
      api.transactions.find_by_notification_code code
    end

    resp.status.must_equal :paid
    resp.items.item.id.must_equal "ba2bf7ee-60cf-40e2-8e90-200223012c52"
    resp.items.item.amount.must_equal "197.00"
    resp.sender.email.wont_be_nil
  end

  it "should handle abandoned transactions" do
    code = "F95301-69CA74CA74F2-E334CF9F97DD-689218"
    stub_request(:get, %r{transactions/notifications}).to_return(
      headers: { "Content-Type" => "application/json" },
      body: JSON.generate(json(:abandoned))
    )

    api = PagSeguro::API.new app: true
    resp = api.transactions.find_by_notification_code code
    resp.must_be :error?
  end
end
