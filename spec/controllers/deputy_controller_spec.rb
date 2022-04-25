require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'

RSpec.describe DeputyController, type: :controller do
  context '#submit_csv' do
    before :each do
      @file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
    end

    it 'Should pass file and uf to ExtractExpenseDataFromCsvService' do
      allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(@file)
      extract_expense_data_from_csv_service = instance_double(ExtractExpenseDataFromCsvService)
      expect(ExtractExpenseDataFromCsvService).to receive(:new).with(file: @file, uf: "RJ").and_return(extract_expense_data_from_csv_service)
      expect(extract_expense_data_from_csv_service).to receive(:call).and_return({})
      post :submit_csv, params: {file: @file, uf: 'RJ'}
    end

    it 'Should save deputies, legislatures and deputy expenses by file' do
      expect {
        post :submit_csv, params: {file: @file}
      }.to change { FinancialManagement::DeputyExpense.count }.by(2).and change { Legislature.count }.by(2).and change { Deputy.count }.by(2) 
    end
  end
end
