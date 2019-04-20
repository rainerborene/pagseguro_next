module PagSeguro
  class Authorizations < Base
    PERMISSIONS = {
      checkouts:            "CREATE_CHECKOUTS",
      notifications:        "RECEIVE_TRANSACTION_NOTIFICATIONS",
      searches:             "SEARCH_TRANSACTIONS",
      payments:             "DIRECT_PAYMENT",
      refunds:              "REFUND_TRANSACTIONS",
      cancels:              "CANCEL_TRANSACTIONS",
      direct_pre_approval:  "USE_DIRECT_PRE_APPROVAL",
      manage_pre_approvals: "MANAGE_PAYMENT_PRE_APPROVALS"
    }

    def create(params)
      xml = build_request(params).to_xml

      response = api.post "/v2/authorizations/request", xml do |conn|
        conn.headers[:content_type] = FORMATS[:xml]
        conn.headers[:accept] = FORMATS[:xml]
      end

      parse response.body["authorizationRequest"]
    end

    def find_by_notification_code(code)
      response = api.get "/v2/authorizations/notifications/#{code}" do |conn|
        conn.headers[:content_type] = FORMATS[:xml]
        conn.headers[:accept] = FORMATS[:xml]
      end

      parse response.body["authorization"]
    end

    def url(code)
      api.build_url :site, "/v2/authorization/request.jhtml", code: code
    end

    private

    def build_request(params)
      builder do
        authorizationRequest do
          redirectURL params[:redirect_url]
          permissions do
            params[:permissions].each do |aliased|
              code PERMISSIONS[aliased]
            end
          end
        end
      end
    end
  end
end
