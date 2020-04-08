# frozen_string_literal: true

module PagSeguro
  class Plans
    include Restful

    def create(params)
      xml = build_request(params).to_xml
      post_xml("/pre-approvals/request", xml)
    end

    def update(code, params)
      params[:amount_per_payment] = to_money params[:amount_per_payment]
      params = parameterize params

      put("/pre-approvals/request/#{code}/payment", params)
    end

    private
      def to_money(value)
        format "%.2f", value.to_f
      end

      def build_request(params)
        builder do
          preApprovalRequest do
            reference params[:reference]
            preApproval do
              charge params[:charge]
              name { cdata(params[:name]) }
              details { cdata(params[:details]) }
              period params[:period]
              amountPerPayment format("%.2f", params[:amount_per_payment])
            end
          end
        end
      end
  end
end
