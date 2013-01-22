class OrcamentosController < ApplicationController

	def index
		@orcamentos = Geo::Service::Orcamento.todos
	end

	def new
		@orcamento = Geo::Service::Orcamento.novo
	end

	def create
		Geo::Service::Orcamento.salvar params[:geo_domain_orcamento]
		redirect_to action: :index
	end
end
