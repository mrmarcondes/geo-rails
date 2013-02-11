Dir['./lib/geo-core/domain/*.rb'].each {|file| require file }
Dir['./lib/geo-core/service/*.rb'].each {|file| require file }

require 'rspec'
require 'rspec/autorun'
