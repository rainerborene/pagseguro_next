# frozen_string_literal: true

module PagSeguro
  class Sessions
    include Restful

    def create
      response = post_xml("/v2/sessions")
      response.session
    end
  end
end
