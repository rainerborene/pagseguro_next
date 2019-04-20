module PagSeguro
  class Sessions < Base
    def create
      response = api.post "/v2/sessions" do |conn|
        conn.headers[:accept] = FORMATS[:xml]
      end

      parse response.body["session"]
    end
  end
end
