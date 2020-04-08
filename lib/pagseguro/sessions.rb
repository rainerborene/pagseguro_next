# frozen_string_literal: true

module PagSeguro
  class Sessions
    include Restful

    def create
      response = post("/v2/sessions", nil, xml: :simple)
      response.session
    end
  end
end
