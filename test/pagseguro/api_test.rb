# frozen_string_literal: true

require "test_helper"

class PagSeguroTest < Minitest::Test
  def test_should_configure_credentials_on_initializer
    assert_respond_to PagSeguro, :token=
    assert_respond_to PagSeguro, :email=
    assert_respond_to PagSeguro, :environment=
    assert_respond_to PagSeguro, :app_id=
    assert_respond_to PagSeguro, :app_key=
  end
end
