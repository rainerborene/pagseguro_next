# frozen_string_literal: true

require "active_support/core_ext/string/inflections"
require "active_support/core_ext/module/delegation"
require "active_support/core_ext/hash/reverse_merge"
require "active_support/core_ext/string/conversions"
require "active_support/core_ext/object/json"
require "active_support/core_ext/module/attribute_accessors"

module PagSeguro
  autoload :Client,         "pagseguro/client"
  autoload :Restful,        "pagseguro/restful"
  autoload :Subscriptions,  "pagseguro/subscriptions"
  autoload :PaymentOrders,  "pagseguro/payment_orders"
  autoload :Sessions,       "pagseguro/sessions"
  autoload :Plans,          "pagseguro/plans"
  autoload :Authorizations, "pagseguro/authorizations"
  autoload :Checkout,       "pagseguro/checkout"
  autoload :Transactions,   "pagseguro/transactions"
  autoload :Mash,           "pagseguro/mash"

  ACCEPTS = {
    json: "application/vnd.pagseguro.com.br.v3+json;charset=ISO-8859-1",
    xml: "application/vnd.pagseguro.com.br.v3+xml;charset=ISO-8859-1"
  }

  FORMATS = {
    json: "application/json;charset=ISO-8859-1",
    xml: "application/xml;charset=ISO-8859-1"
  }

  mattr_accessor :token
  mattr_accessor :email
  mattr_accessor :app_id
  mattr_accessor :app_key
  mattr_accessor :environment

  def self.configure(&block)
    instance_eval(&block)
  end

  def self.uris
    @uris ||= {
      production: {
        api: "https://ws.pagseguro.uol.com.br",
        site: "https://pagseguro.uol.com.br"
      },
      sandbox: {
        api:  "https://ws.sandbox.pagseguro.uol.com.br",
        site: "https://sandbox.pagseguro.uol.com.br"
      }
    }
  end
end
