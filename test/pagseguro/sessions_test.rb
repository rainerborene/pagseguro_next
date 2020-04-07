# frozen_string_literal: true

require "test_helper"

class PagSeguro::SessionsTest < Minitest::Test
  def test_create_a_new_session_identifier
    response = VCR.use_cassette "sessions" do
      client = PagSeguro::Client.new
      client.sessions.create
    end

    assert_equal "5ceb7ede8c574114a1a1aab79fdf807e", response.id
  end
end
