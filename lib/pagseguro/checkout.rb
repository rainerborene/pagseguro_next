module PagSeguro
  class Checkout < Base
    def create(params)
      params = build_request(params).to_xml

      response = api.post "/v2/checkout", params do |conn|
        conn.headers[:content_type] = FORMATS[:xml]
        conn.headers[:accept] = FORMATS[:xml]
      end

      parse response.body["checkout"]
    end

    def url(code)
      api.build_url :site, "/v2/checkout/payment.html", code: code
    end

    private

    def build_request(params)
      builder do
        checkout do
          currency "BRL"
          sender do
            ip params[:remote_ip]
          end if params.key?(:remote_ip)
          items do
            item do
              id params[:id]
              description params[:description]
              amount format("%.2f", params[:amount].to_f)
              quantity 1
            end
          end
          shipping do
            addressRequired false
          end
        end
      end
    end
  end
end
