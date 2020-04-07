# frozen_string_literal: true

require "test_helper"

class PagSeguro::PlansTest < Minitest::Test
  def setup
    @client = PagSeguro::Client.new
  end

  def test_create_new_plan
    plan = VCR.use_cassette "plan-create" do
      @client.plans.create(
        charge: "auto",
        name: "App",
        details: "Awesome app",
        period: "monthly",
        amount_per_payment: 199.0
      )
    end

    assert_equal "BED5B6EF7C7C962AA4D75F95BD9308C4", plan.code
  end

  def test_update_plan_attributes
    code = "BED5B6EF7C7C962AA4D75F95BD9308C4"
    response = VCR.use_cassette "plan-update" do
      @client.plans.update(code, amount_per_payment: 197.0, update_subscriptions: false)
    end

    assert_empty response
  end
end
