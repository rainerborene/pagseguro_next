# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pagseguro/version"

Gem::Specification.new do |spec|
  spec.name          = "pagseguro_next"
  spec.version       = PagSeguro::VERSION
  spec.authors       = ["Rainer Borene"]
  spec.email         = ["rainerborene@gmail.com"]

  spec.summary       = "Yet another client to PagSeguro API"
  spec.description   = "Yet another client to PagSeguro API"
  spec.homepage      = "https://github.com/rainerborene/pagseguro_next"
  spec.license       = "MIT"
  spec.files         = %w(README.md Rakefile pagseguro_next.gemspec)
  spec.files        += Dir.glob("lib/**/*.rb")
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", [">= 0.7.4", "< 1.0"]
  spec.add_dependency "faraday_middleware", "~> 0.13"
  spec.add_dependency "hashie", [">= 3.4.6", "< 3.7.0"]
  spec.add_dependency "nokogiri", ">= 1.6"
  spec.add_dependency "activesupport", ">= 4"
  spec.add_dependency "multi_xml", "0.6.0"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "vcr", "~> 4.0"
  spec.add_development_dependency "webmock", "~> 3.5"
end
