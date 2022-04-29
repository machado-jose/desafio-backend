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
    include ActiveJob::TestHelper

    before :each do
      ActiveJob::Base.queue_adapter = :test
      @file = fixture_file_upload('services/register_deputies_expenses/Ano-2021.csv', 'text/csv')
      allow(Thread).to receive(:new).and_yield
      allow(RegisterDeputyExpenseJob).to receive(:perform_later)
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
        create(:file_control, expense_year: '2021')
        expect(@extract_expense_data_from_csv_service).to receive(:call).and_return({"111" => [{'numAno' => '2021'}]})
        post :submit_csv, params: {file: @file}
        expect(response).to redirect_to(root_url)
      end

      it 'when raise an error' do
        expect(@extract_expense_data_from_csv_service).to receive(:call).and_raise(StandardError)
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

  context '#details' do
    it 'Should return deputy without expense' do
      deputy = create(:deputy)
      get :details, params: { id: deputy.id }
      expect(assigns(:deputy)).to eq(deputy)
      expect(assigns(:expenses_by_month).empty?).to be_truthy
    end

    it 'Should return deputy with expense' do
      deputy_expense = create(:deputy_expense, expense_year: '2021')
      deputy = deputy_expense.legislature.deputy
      get :details, params: { id: deputy.id }
      expect(assigns(:deputy)).to eq(deputy)
      expect(assigns(:expenses_by_month).empty?).to be_falsey
    end

    it 'Should redirect to root path when deputy not present' do
      get :details, params: { id: 'any_id' }
      expect(response).to redirect_to(root_url)
    end
  end
end
