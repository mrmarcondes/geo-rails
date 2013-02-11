require 'spec_helper'

describe Geo::Service::Orcamento do

  describe "criando orcamento" do
    let(:orcamento_valido) do
      {
        descricao: "minha_descricao", cliente: "meu_cliente", 
        itens_attributes: {
                          "0" => {codigo_material: "1.1", quantidade: "1"}, 
                          "1" => {codigo_material: "2.2", quantidade: "2"}
                          }
      }
    end

    let(:orcamento_invalido) {{descricao: nil, cliente: "meu_cliente"}}

    it "deve salvar um orcamento valido" do
      orcamento = mock(:Orcamento, :itens => [])
      Geo::Domain::Orcamento.should_receive(:new).with(orcamento_valido).and_return(orcamento)
      orcamento.should_receive(:valid?).and_return(true)
      orcamento.should_receive(:save)
      orcamento.should_receive(:itens=).with(Array.new)
      Geo::Service::Orcamento.salvar orcamento_valido
    end

    it "deve rejeitar um orcamento invalido" do
      orcamento= mock(:Orcamento, :itens => [], :errors => TypeError.new)
      Geo::Domain::Orcamento.should_receive(:new).with(orcamento_invalido).and_return(orcamento)
      orcamento.should_receive(:valid?).and_return(false)
      expect { Geo::Service::Orcamento.salvar orcamento_invalido}.to raise_error(orcamento.errors)
    end
  end

  describe "localizacao" do
    let(:latitude){double(:Float)}
    let(:longitude){double(:Float)}
    let(:endereco){double(:endereco)}
    let(:item_orcamento){mock(:ItemOrcamento, latitude: 0, longitude: 0)}

    it "deve localizar o endereco de um item de orcamento a partir de latitude e longitude fornecidos" do
      Geo::Domain::ItemOrcamento.should_receive(:find).with(:item_orcamento_id).and_return(item_orcamento)
      Geo::Service::Orcamento.should_receive(:atualizar_endereco).with(item_orcamento, latitude, longitude).and_return(item_orcamento)
      Geo::Service::Orcamento.atualizar_localizacao(:item_orcamento_id => :item_orcamento_id, latitude: latitude, longitude: longitude)
    end

    it "nao deve localizar o endereco de um item de orcamento invalido" do
      Geo::Domain::ItemOrcamento.should_receive(:find).with(:item_orcamento_id).and_return(nil)
      Geo::Service::Orcamento.atualizar_localizacao(:item_orcamento_id => :item_orcamento_id, latitude: latitude, longitude: longitude)
    end

    it "nao deve localizar o endereco de um item de orcamento sem latitude e longitude" do
      Geo::Domain::ItemOrcamento.should_receive(:find).with(:item_orcamento_id).and_return(item_orcamento)
      Geo::Service::Orcamento.atualizar_localizacao(:item_orcamento_id => :item_orcamento_id)
    end

    it "nao deve localizar o endereco de um item de orcamento invalido, sem latitude e longitude" do
      Geo::Domain::ItemOrcamento.should_receive(:find).with(:item_orcamento_id).and_return(item_orcamento)
      Geo::Service::Orcamento.atualizar_localizacao(:item_orcamento_id => :item_orcamento_id)
    end

  end

end
