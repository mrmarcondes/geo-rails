require 'mongoid'
require 'geo-core/domain/orcamento'
require 'geo-core/domain/item_orcamento'
require 'geo-core/service/orcamento_service'

current_path = File.expand_path File.dirname(__FILE__) 
Mongoid.load!(current_path << "/mongoid.yml", :production)
