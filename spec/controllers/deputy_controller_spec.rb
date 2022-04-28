require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'
require './app/services/infrastructure/parse_csv_file_service.rb'

RSpec.describe DeputyController, type: :controller do
  context '#index' do
    it 'Should return status code 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context '#submit_csv' do
    before :each do
      @file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
      allow(Thread).to receive(:new).and_yield
    end

    it 'Should pass file and uf to ExtractExpenseDataFromCsvService' do
      allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(@file)
      parse_csv_file_service = instance_double(ParseCsvFileService)
      expect(ParseCsvFileService).to receive(:new).with(file: @file).and_return(parse_csv_file_service)
      extract_expense_data_from_csv_service = instance_double(ExtractExpenseDataFromCsvService)
      expect(ExtractExpenseDataFromCsvService).to receive(:new)
                                                  .with(parse_csv_file_service: parse_csv_file_service, uf: "RJ")
                                                  .and_return(extract_expense_data_from_csv_service)
      expect(extract_expense_data_from_csv_service).to receive(:call).and_return({"111" => [{'numAno' => '2021'}]})
      post :submit_csv, params: {file: @file}
    end

    it 'Should save deputies, legislatures and deputy expenses by file' do
      expect {
        post :submit_csv, params: {file: @file}
      }.to change { FinancialManagement::DeputyExpense.count }.by(1).and change { Legislature.count }.by(1).and change { Deputy.count }.by(1) 
    end

    it 'Should back to transaction when raise an error' do
      add_expense_service = instance_double(AddExpenseService)
      expect(AddExpenseService).to receive(:new).and_return(add_expense_service)
      expect(add_expense_service).to receive(:call).and_raise(ActiveModel::StrictValidationFailed)
      expect {
        post :submit_csv, params: {file: @file}
      }.to change { Deputy.count }.by(0)
    end

    context 'Should redirect to root path' do
      before :each do
        allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(@file)
        parse_csv_file_service = instance_double(ParseCsvFileService)
        expect(ParseCsvFileService).to receive(:new).with(file: @file).and_return(parse_csv_file_service)
        @extract_expense_data_from_csv_service = instance_double(ExtractExpenseDataFromCsvService)
        expect(ExtractExpenseDataFromCsvService).to receive(:new)
                                                    .with(parse_csv_file_service: parse_csv_file_service, uf: "RJ")
                                                    .and_return(@extract_expense_data_from_csv_service)
      end

      it 'when expense_data is empty' do
        expect(@extract_expense_data_from_csv_service).to receive(:call).and_return({})
        post :submit_csv, params: {file: @file}
        expect(response).to redirect_to(root_url)
      end

      it 'when file was submitted' do
        expect(@extract_expense_data_from_csv_service).to receive(:call).and_return({"111" => [{'numAno' => '2021'}]})
        create_file_control_service = instance_double(CreateFileControlService)
        expect(CreateFileControlService).to receive(:new)
                                                    .with(expense_year: '2021')
                                                    .and_return(create_file_control_service)
        expect(create_file_control_service).to receive(:call).and_return(false)
        post :submit_csv, params: {file: @file}
        expect(response).to redirect_to(root_url)
      end
    end
  end

  context '#rank' do
    it 'Should return all deputies' do
      create(:deputy)
      create(:deputy)
      get :rank
      expect(assigns(:deputies).count).to eq(2)
    end

    it 'Should return empty' do
      get :rank
      expect(assigns(:deputies).empty?).to be_truthy
    end
  end
end
