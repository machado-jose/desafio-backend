require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'

RSpec.describe DeputyController, type: :controller do
  context '#submit_csv' do
    before :each do
      @file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
      allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(@file)
    end

    it 'Should pass file and uf to ExtractExpenseDataFromCsvService' do
      extract_expense_data_from_csv_service = instance_double(ExtractExpenseDataFromCsvService)
      expect(ExtractExpenseDataFromCsvService).to receive(:new).with(file: @file, uf: "RJ").and_return(extract_expense_data_from_csv_service)
      expect(extract_expense_data_from_csv_service).to receive(:call).and_return({})
      post :submit_csv, params: {file: @file, uf: 'RJ'}
    end
  end
end
