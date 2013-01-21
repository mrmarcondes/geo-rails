class OrcamentosController < ApplicationController

	def new
		@orcamento = Geo::Service::Orcamento.novo
	end

	def create
		Geo::Service::Orcamento.salvar params[:geo_domain_orcamento]
	end
end
