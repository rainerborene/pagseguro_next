require "spec_helper"

describe PagSeguro::Plans do
  it "should create new plan" do
    plan = VCR.use_cassette "plan-create" do
      api = PagSeguro::API.new
      api.plans.create(
        charge: "auto",
        name: "App",
        details: "Awesome app",
        period: "monthly",
        amount_per_payment: 199.0
      )
    end

    plan.code.must_equal "BED5B6EF7C7C962AA4D75F95BD9308C4"
  end

  it "should update plan attributes" do
    code = "BED5B6EF7C7C962AA4D75F95BD9308C4"
    response = VCR.use_cassette "plan-update" do
      api = PagSeguro::API.new
      api.plans.update(code, amount_per_payment: 197.0,
                             update_subscriptions: false)
    end

    response.must_be(:success?)
  end
end
