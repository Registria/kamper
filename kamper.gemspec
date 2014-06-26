# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kamper/version'

Gem::Specification.new do |spec|
  spec.name          = "kamper"
  spec.version       = Kamper::VERSION
  spec.authors       = ["Marcus Young"]
  spec.date          = %q{2014-06-19}
  spec.email         = ["marcus@registria.com"]
  spec.summary       = %q{Ruby wrapper for the KnowledgeBase Manager Pro xmlrpc api}
  spec.description   = %q{Leverage KnowledgeBase Manager Pro API using idiomatic(ish) Ruby.}
  spec.homepage      = %q{https://github.com/marchyoung/kamper}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 1.3"
  spec.add_development_dependency "mocha", "~> 0.12.8"
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'pry', "~> 0.9.0"
end
