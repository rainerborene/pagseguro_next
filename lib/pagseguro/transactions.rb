# frozen_string_literal: true

module PagSeguro
  class Transactions
    include Restful

    STATUSES = {
      "0" => :initiated,
      "1" => :waiting_payment,
      "2" => :in_analysis,
      "3" => :paid,
      "4" => :available,
      "5" => :in_dispute,
      "6" => :refunded,
      "7" => :cancelled,
      "8" => :chargeback_charged,
      "9" => :contested
    }

    def find(code)
      transform get_xml("/v3/transactions/#{code}")
    end

    def find_by_notification_code(code)
      transform get_xml("/v2/transactions/notifications/#{code}")
    end

    private
      def transform(body)
        if body.transaction?
          body.transaction.status = STATUSES[body.transaction.status]
          body.transaction
        elsif body.errors?
          body.errors
        else
          body
        end
      end
  end
end
