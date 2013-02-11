require_relative '../domain/orcamento.rb'
require_relative '../domain/item_orcamento.rb'
require 'geocoder'

module Geo
	module Service
		class Orcamento
			def self.novo
				return Geo::Domain::Orcamento.new
			end

			#FIXME fazer tratamento de errors
			def self.salvar(params)
				begin
					orcamento = Geo::Domain::Orcamento.new params
					raise orcamento.errors unless orcamento.valid? 
					orcamento.save
					orcamento.itens= Array.new
					orcamento.itens.push criar_itens params[:itens_attributes]
					return orcamento
				rescue Exception => e
					raise e
				end					
			end

			private
				def self.criar_itens(param)
					return if !param
					itens = Array.new
					param.each do |chave, valor|
						item = Geo::Domain::ItemOrcamento.new valor
						itens.push item if item.valid?
					end
					return itens
				end


			def self.todos
				return Geo::Domain::Orcamento.all
			end

			def self.por_id id
				return Geo::Domain::Orcamento.find id
			end

			def self.item_orcamento_por_id id
				return Geo::Domain::ItemOrcamento.find id
			end

			def self.atualizar_localizacao(params)
				item_orcamento= Geo::Domain::ItemOrcamento.find(params[:item_orcamento_id])
				if item_orcamento and params[:latitude] and params[:longitude]
					return atualizar_endereco(item_orcamento, params[:latitude], params[:longitude])
				end
				return nil
			end

			private
				def self.atualizar_endereco(item_orcamento, latitude, longitude)
					item_orcamento.latitude= latitude
					item_orcamento.longitude= longitude
					item_orcamento.endereco_instalacao = buscar_endereco(latitude, longitude)
					if item_orcamento.save
						return item_orcamento
					end
					return nil
				end

				def self.buscar_endereco(latitude, longitude)
					return Geocoder.search("#{latitude},#{longitude}")[0].formatted_address
				end
		end
	end
end



