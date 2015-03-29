# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spotlight/atom/version'

Gem::Specification.new do |spec|
  spec.name          = "spotlight-atom"
  spec.version       = Spotlight::Atom::VERSION
  spec.authors       = ["Chris Beer", "Jessie Keck"]
  spec.email         = ["chris@cbeer.info", "jkeck@stanford.edu"]
  spec.summary       = %q{Harvesting atom feeds into Spotlight}
  spec.homepage      = ""
  spec.license       = "Apache 2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "blacklight-spotlight"
  spec.add_dependency "faraday"
  
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-rails", "~> 3.1"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "poltergeist", ">= 1.5.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "engine_cart"
  spec.add_development_dependency "jettywrapper"
end
