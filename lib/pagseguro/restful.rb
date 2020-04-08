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
      def get(path, options = {}, xml: nil)
        headers = headerize(xml) if xml
        connection.get(path, options, headers).body
      end

      def post(path, options = {}, xml: nil)
        headers = headerize(xml) if xml
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

      def headerize(xml)
        if xml == :simple
          { accept: FORMATS[:xml], content_type: FORMATS[:xml] }
        elsif xml == :versioned
          { accept: ACCEPTS[:xml], content_type: FORMATS[:xml] }
        end
      end

      def parameterize(hash)
        hash.as_json.deep_transform_keys! { |key| key.to_s.camelize(:lower) }
      end

      def builder(&block)
        Nokogiri::XML::Builder.new { |xml| xml.instance_eval(&block) }
      end
  end
end
