# frozen_string_literal: true

require "nokogiri"

module PagSeguro
  module Restful
    attr_reader :client

    delegate :url_for, :connection, to: :client

    def initialize(client)
      @client = client
    end

    protected
      def get(path, options = nil, headers = nil)
        connection.get(path, options, headers).body
      end

      def post(path, options = nil, headers = nil)
        connection.post(path, options, headers).body
      end

      def put(path, options = {})
        connection.put(path, options).body
      end

      def patch(path, options = {})
        connection.patch(path, options).body
      end

      def delete(path, options = {})
        connection.delete(path, options).body
      end

      def xml_headers
        { accept: ACCEPTS[:xml], content_type: FORMATS[:xml] }
      end

      def get_xml(path, options = nil)
        get(path, options, xml_headers)
      end

      def post_xml(path, options = nil)
        post(path, options, xml_headers)
      end

      def parameterize(hash)
        hash.as_json.deep_transform_keys! { |key| key.to_s.camelize(:lower) }
      end

      def builder(&block)
        Nokogiri::XML::Builder.new { |xml| xml.instance_eval(&block) }
      end
  end
end
