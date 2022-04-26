require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'
require './app/services/infrastructure/parse_csv_file_service.rb'

describe 'ExtractExpenseDataFromCsvService' do  
  context '#call' do
    before :each do
      file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
      @parse_csv_file_service = ParseCsvFileService.new(file: file)
    end

    it 'Should return hash with deputies expenses data filter by uf' do
      response = ExtractExpenseDataFromCsvService.new(parse_csv_file_service: @parse_csv_file_service, uf: "RJ").call
      expect(response["160511"].first["txNomeParlamentar"]).to eq("Alessandro Molon")
      expect(response["160511"].first["cpf"]).to eq("1416576770")
      expect(response["160511"].first["nuCarteiraParlamentar"]).to eq("287")
      expect(response["160511"].first["nuLegislatura"]).to eq("2019")
      expect(response["160511"].first["sgUF"]).to eq("RJ")
      expect(response["160511"].first["sgPartido"]).to eq("PSB")
      expect(response["160511"].first["codLegislatura"]).to eq("56")
      expect(response["160511"].first["numSubCota"]).to eq("122")
      expect(response["160511"].first["txtDescricao"]).to eq("SERVIÇO DE TÁXI, PEDÁGIO E ESTACIONAMENTO")
      expect(response["160511"].first["numEspecificacaoSubCota"]).to eq("0")
      expect(response["160511"].first["txtDescricaoEspecificacao"]).to eq(nil)
      expect(response["160511"].first["txtFornecedor"]).to eq("ASSOCIACAO NACIONAL DE TAXISTAS INFORMATIZADOS ANTAXI")
      expect(response["160511"].first["txtCNPJCPF"]).to eq("306.059.770/0010-1")
      expect(response["160511"].first["txtNumero"]).to eq("s/n")
      expect(response["160511"].first["indTipoDocumento"]).to eq("1")
      expect(response["160511"].first["datEmissao"]).to eq("2021-10-04T00:00:00")
      expect(response["160511"].first["vlrDocumento"]).to eq("82")
      expect(response["160511"].first["vlrGlosa"]).to eq("0")
      expect(response["160511"].first["vlrLiquido"]).to eq("82")
      expect(response["160511"].first["numMes"]).to eq("10")
      expect(response["160511"].first["numAno"]).to eq("2021")
      expect(response["160511"].first["numParcela"]).to eq("0")
      expect(response["160511"].first["txtPassageiro"]).to eq(nil)
      expect(response["160511"].first["txtTrecho"]).to eq(nil)
      expect(response["160511"].first["numLote"]).to eq("1805034")
      expect(response["160511"].first["numRessarcimento"]).to eq(nil)
      expect(response["160511"].first["vlrRestituicao"]).to eq(nil)
      expect(response["160511"].first["nuDeputadoId"]).to eq("2240")
      expect(response["160511"].first["ideDocumento"]).to eq("7279940")
      expect(response["160511"].first["urlDocumento"]).to eq("https://www.camara.leg.br/cota-parlamentar/documentos/publ/2240/2021/7279940.pdf")
    end

    it 'Should return expenses data list of one deputy' do
      response = ExtractExpenseDataFromCsvService.new(parse_csv_file_service: @parse_csv_file_service, uf: "SC").call
      expect(response["141405"].count).to eq(2)
      expect(response["141405"].first["vlrLiquido"]).to eq("3500")
      expect(response["141405"].second["vlrLiquido"]).to eq("3600")
    end

    it 'Should return all expenses data on csv file' do
      response = ExtractExpenseDataFromCsvService.new(parse_csv_file_service: @parse_csv_file_service).call
      expect(response.keys.count).to eq(2)
      expect(response["141405"].count).to eq(2)
      expect(response["160511"].count).to eq(1)
    end

    context 'Should must raise an error' do
      it 'when uf is empty' do
        expect{
          ExtractExpenseDataFromCsvService.new(parse_csv_file_service: @parse_csv_file_service, uf: '').call
        }.to raise_error(ArgumentError)
      end

      it 'when uf is not String' do
        expect{
          ExtractExpenseDataFromCsvService.new(parse_csv_file_service: @parse_csv_file_service, uf: 30).call
        }.to raise_error(ArgumentError)
      end
    end
  end
end
