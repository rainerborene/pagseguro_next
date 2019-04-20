require "spec_helper"

describe PagSeguro do
  it "should configure credentials on initializer" do
    PagSeguro.must_respond_to :token=
    PagSeguro.must_respond_to :email=
    PagSeguro.must_respond_to :environment=
    PagSeguro.must_respond_to :app_id=
    PagSeguro.must_respond_to :app_key=
  end
end
