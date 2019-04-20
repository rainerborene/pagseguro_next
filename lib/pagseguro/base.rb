require "nokogiri"

module PagSeguro
  class Base
    attr_reader :api

    def initialize(api)
      @api = api
    end

    def parse(hash)
      Response.new(hash)
    end

    def parse_body(response)
      parse response.body
    end

    def parameterize(hash)
      hash.as_json.deep_transform_keys! do |key|
        key.to_s.camelize(:lower)
      end
    end

    def builder(&block)
      Nokogiri::XML::Builder.new do |xml|
        xml.instance_eval(&block)
      end
    end
  end
end
