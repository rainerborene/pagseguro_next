# frozen_string_literal: true

module PagSeguro
  class Checkout
    include Restful

    def create(params)
      params = build_request(params).to_xml(encoding: "UTF-8")
      response = post_xml("/v2/checkout", params)
      response.checkout
    end

    def url(code)
      url_for :site, "/v2/checkout/payment.html", code: code
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
                description { cdata(params[:description]) }
                amount format("%.2f", params[:amount])
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
