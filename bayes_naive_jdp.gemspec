# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bayes_naive_jdp/version'

Gem::Specification.new do |spec|
  spec.name          = "bayes_naive_jdp"
  spec.version       = BayesNaiveJdp::VERSION
  spec.authors       = ["Jason Pollentier"]
  spec.email         = ["pollentj@gmail.com"]
  spec.description   = %q{A very simple naive Bayesian classifier.}
  spec.summary       = %q{A very simple naive Bayesian classifier.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
