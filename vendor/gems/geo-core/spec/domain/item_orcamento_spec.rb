require 'spec_helper'

describe Geo::Domain::ItemOrcamento do
  describe "criacao" do

  	it "deve criar passando parametros validos" do
  		item_orcamento = Geo::Domain::ItemOrcamento.new(codigo_material: "123", quantidade: 100)
  		item_orcamento.codigo_material.should eq("123")
  		item_orcamento.quantidade.should eq(100)
  	end

    it "nao deve criar passando um item sem material" do
    	item_orcamento = Geo::Domain::ItemOrcamento.new(codigo_material: nil, quantidade: 100)
      item_orcamento.should_not be_valid
    end

    it "nao deve criar passando quantidade invalida" do
      item_orcamento = Geo::Domain::ItemOrcamento.new(codigo_material: "2", quantidade: "qw")
      item_orcamento.should_not be_valid
    end
  end
end

