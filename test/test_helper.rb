# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pagseguro_next"
require "minitest/autorun"
require "vcr"
require "webmock/minitest"

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes/pagseguro"
  config.hook_into :webmock
end

PagSeguro.configure do |config|
  config.app_id = "app8068575542"
  config.app_key = "014970ADA1A1E66994443FB99E18B125"
  config.email = "rainerborene@gmail.com"
  config.token = "95C04C6646BD4DA1948CBAF0684EAE7A"
  config.environment = :sandbox
end

class Minitest::Test
  def json_fixture(name)
    JSON.load File.read("test/fixtures/pagseguro/#{name}.json")
  end

  # test/unit backwards compatibility methods
  alias :assert_raise :assert_raises
  alias :assert_not_empty :refute_empty
  alias :assert_not_equal :refute_equal
  alias :assert_not_in_delta :refute_in_delta
  alias :assert_not_in_epsilon :refute_in_epsilon
  alias :assert_not_includes :refute_includes
  alias :assert_not_instance_of :refute_instance_of
  alias :assert_not_kind_of :refute_kind_of
  alias :assert_no_match :refute_match
  alias :assert_not_nil :refute_nil
  alias :assert_not_operator :refute_operator
  alias :assert_not_predicate :refute_predicate
  alias :assert_not_respond_to :refute_respond_to
  alias :assert_not_same :refute_same
end
