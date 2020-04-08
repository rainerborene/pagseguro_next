# frozen_string_literal: true

require "faraday"
require "faraday_middleware"

module PagSeguro
  class Client
    attr_reader :options, :logger, :connection

    def initialize(options = {})
      @options = options
      @logger = options.delete(:logger)
      @connection = Faraday.new api_url do |conn|
        conn.request :json
        conn.response :logger, logger, bodies: true if logger
        conn.response :mashify, mash_class: PagSeguro::Mash
        conn.response :xml,  content_type: /\bxml$/
        conn.response :json, content_type: /\bjson$/
        conn.response :raise_error
        conn.adapter :net_http
        conn.params = auth_params
        conn.headers[:accept] = ACCEPTS[:json]
      end
    end

    def subscriptions
      @subscriptions ||= Subscriptions.new(self)
    end

    def payment_orders
      @payment_orders ||= PaymentOrders.new(self)
    end

    def sessions
      @sessions ||= Sessions.new(self)
    end

    def plans
      @plans ||= Plans.new(self)
    end

    def authorizations
      @authorizations ||= Authorizations.new(self)
    end

    def checkout
      @checkout ||= Checkout.new(self)
    end

    def transactions
      @transactions ||= Transactions.new(self)
    end

    def url_for(source, path, params = {})
      url = URI(send("#{source}_url"))
      url.path = path
      url.query = params.to_query
      url.to_s
    end

    protected
      def environment
        options[:environment] || PagSeguro.environment
      end

      def site_url
        PagSeguro.uris[environment.to_sym][:site]
      end

      def api_url
        PagSeguro.uris[environment.to_sym][:api]
      end

      def auth_params
        auth = {}

        if options.key?(:app) || options.key?(:app_id)
          auth[:appId]  = options.fetch :app_id, PagSeguro.app_id
          auth[:appKey] = options.fetch :app_key, PagSeguro.app_key
          auth[:authorizationCode] = options[:authorization_code]
        else
          auth[:token] = options.fetch :token, PagSeguro.token
          auth[:email] = options.fetch :email, PagSeguro.email
        end

        auth.compact
      end
  end
end
