# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spree_robokassa/version'
 
Gem::Specification.new do |spec|
  spec.name          = "spree_robokassa"
  spec.version       = SpreeRobokassa::VERSION
  spec.authors       = ["Artem Aminov"]
  spec.email         = ["artemaminov@gmail.com"]
  spec.description   = "Robokassa gem for Spree. Integrates Robokassa payment"
  spec.summary       = "Add Robokassa payment to Spree"
  spec.homepage      = "http://github.com/artemaminov/spree_robokassa.git"
  spec.license       = "MIT"
 
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
 
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end