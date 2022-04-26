require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'
require './app/services/infrastructure/parse_csv_file_service.rb'

RSpec.describe DeputyController, type: :controller do
  context '#submit_csv' do
    before :each do
      @file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
    end

    it 'Should pass file and uf to ExtractExpenseDataFromCsvService' do
      allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(@file)
      parse_csv_file_service = instance_double(ParseCsvFileService)
      expect(ParseCsvFileService).to receive(:new).with(file: @file).and_return(parse_csv_file_service)
      extract_expense_data_from_csv_service = instance_double(ExtractExpenseDataFromCsvService)
      expect(ExtractExpenseDataFromCsvService).to receive(:new)
                                                  .with(parse_csv_file_service: parse_csv_file_service, uf: "RJ")
                                                  .and_return(extract_expense_data_from_csv_service)
      expect(extract_expense_data_from_csv_service).to receive(:call).and_return({})
      post :submit_csv, params: {file: @file, uf: 'RJ'}
    end

    it 'Should save deputies, legislatures and deputy expenses by file' do
      expect {
        post :submit_csv, params: {file: @file}
      }.to change { FinancialManagement::DeputyExpense.count }.by(2).and change { Legislature.count }.by(2).and change { Deputy.count }.by(2) 
    end

    it 'Should back to transaction when raise an error' do
      add_expense_service = instance_double(AddExpenseService)
      expect(AddExpenseService).to receive(:new).and_return(add_expense_service)
      expect(add_expense_service).to receive(:call).and_raise(ActiveModel::StrictValidationFailed)
      expect {
        post :submit_csv, params: {file: @file}
      }.to change { Deputy.count }.by(0)
    end
  end
end
