module PagSeguro
  class Transactions < Base
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
      response = api.get "/v3/transactions/#{code}" do |conn|
        conn.headers[:accept] = FORMATS[:xml]
      end

      parse_body response
    end

    def find_by_notification_code(code)
      response = api.get "/v2/transactions/notifications/#{code}" do |conn|
        conn.headers[:accept] = FORMATS[:xml]
      end

      parse_body response
    end

    private

    def parse_body(response)
      parse(response.body["transaction"]).tap do |transaction|
        transaction.status = STATUSES[transaction.status]
      end
    end
  end
end
