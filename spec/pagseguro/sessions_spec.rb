require "spec_helper"

describe PagSeguro::Sessions do
  it "should create a new session identifier" do
    response = VCR.use_cassette "sessions" do
      api = PagSeguro::API.new
      api.sessions.create
    end

    response.id.must_equal "5ceb7ede8c574114a1a1aab79fdf807e"
  end
end
