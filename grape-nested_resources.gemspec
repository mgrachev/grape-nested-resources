# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/grape/nested_resources/version'

Gem::Specification.new do |spec|
  spec.name          = "grape-nested_resources"
  spec.version       = Grape::NestedResources::VERSION
  spec.authors       = ["Mikhail Grachev"]
  spec.email         = ["work@mgrachev.com"]

  spec.summary       = %q{Generate urls for nested resource with Grape.}
  spec.description   = %q{Generate urls for nested resource with Grape.}
  spec.homepage      = ""

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'grape'
  spec.add_dependency 'activesupport'
end
