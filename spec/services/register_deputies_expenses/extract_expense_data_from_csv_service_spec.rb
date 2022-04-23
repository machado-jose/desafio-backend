require 'rails_helper'
require './app/services/register_deputies_expenses/extract_expense_data_from_csv_service.rb'

describe 'ExtractExpenseDataFromCsvService' do  
  context '#call' do
    before :each do
      @file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
    end

    it 'Should return hash with deputies expenses data filter by uf' do
      response = ExtractExpenseDataFromCsvService.new(file: @file, uf: "RJ").call
      expect(response["160511"]["txNomeParlamentar"]).to eq("Alessandro Molon")
      expect(response["160511"]["txtDescricao"]).to eq("SERVIÇO DE TÁXI, PEDÁGIO E ESTACIONAMENTO")
    end
  end
end
