$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pagseguro_next"
require "minitest/autorun"
require "vcr"
require "webmock"
require "pry"

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes/pagseguro"
  config.hook_into :webmock
end

PagSeguro.configure do |config|
  config.app_id = "app8068575542"
  config.app_key = "014970ADA1A1E66994443FB99E18B125"
  config.email = "rainerborene@gmail.com"
  config.token = "95C04C6646BD4DA1948CBAF0684EAE7A"
  config.environment = :sandbox
end

class Minitest::Spec
  def json(name)
    JSON.load File.read("spec/fixtures/#{name}.json")
  end
end
