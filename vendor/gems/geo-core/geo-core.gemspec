# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geo-core/version'

Gem::Specification.new do |gem|
  gem.name          = "geo-core"
  gem.version       = Geo::Core::VERSION
  gem.authors       = ["Marco Rojo"]
  gem.email         = ["mrmarcondes@gmail.com"]
  gem.description   = %q{Apenas um teste}
  gem.summary       = %q{Apenas um teste}
  gem.homepage      = ""

  gem.add_dependency  "mongoid"
  gem.add_dependency  "geocoder"

  gem.files         = Dir['lib/**/*.rb'] + Dir['lib/*.yml'] + Dir['*.*']
  gem.require_paths = ["lib"]
end
