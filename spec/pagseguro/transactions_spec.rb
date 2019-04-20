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
end
