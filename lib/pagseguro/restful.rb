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
      def get(path, options = nil, &block)
        connection.get(path, options, &block).body
      end

      def post(path, options = nil, &block)
        connection.post(path, options, &block).body
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

      def get_xml(path, options = nil)
        get(path, options) do |conn|
          conn.headers[:content_type] = FORMATS[:xml]
          conn.headers[:accept] = FORMATS[:xml]
        end
      end

      def post_xml(path, options = nil)
        post(path) do |conn|
          conn.headers[:content_type] = FORMATS[:xml]
          conn.headers[:accept] = FORMATS[:xml]
        end
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
