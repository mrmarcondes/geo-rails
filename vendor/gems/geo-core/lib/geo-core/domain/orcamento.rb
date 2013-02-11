require_relative '../../geo-core.rb'

module Geo
	module Domain
		class Orcamento
			include Mongoid::Document
			store_in collection: "orcamentos"

			field :cliente
			field :descricao

			has_many :itens, class_name: 'Geo::Domain::ItemOrcamento'

			validates :cliente, :descricao, presence: true

			#necessario por conta do form.fields_for do rails
		 	def itens_attributes=(attributes)
		  end	
	
		end
	end
end