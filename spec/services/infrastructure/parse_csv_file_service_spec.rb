require 'rails_helper'
require './app/services/infrastructure/parse_csv_file_service.rb'

describe 'ParseCsvFileService' do
  context '#call' do
    it 'Should parse with successfully' do
      file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
      csv = ParseCsvFileService.new(file: file).call
      expect(csv.headers.count).to eq(31)
    end

    it 'Should parse csv after raise CSV::MalformedCSVError' do
      file = fixture_file_upload('services/register_deputies_expenses/mal_formatted.csv', 'text/csv')
      csv = ParseCsvFileService.new(file: file).call
      expect(csv.headers.count).to eq(31)
    end
  end
end
