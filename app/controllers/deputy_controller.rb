require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'
require './app/services/deputy_management/register_deputies_expenses/analyze_expense_data_service.rb'
require './app/services/deputy_management/create_deputy_service.rb'
require './app/services/deputy_management/register_deputies_expenses/add_expense_service.rb'
require './app/services/infrastructure/parse_csv_file_service.rb'

class DeputyController < ApplicationController
  def index

  end
  
  def submit_csv
    parse_csv_file_service = ParseCsvFileService.new(file: params[:file])
    expense_data = ExtractExpenseDataFromCsvService.new(
                                                          parse_csv_file_service: parse_csv_file_service, 
                                                          uf: params[:uf]
                                                        ).call
    ActiveRecord::Base.transaction do
      AnalyzeExpenseDataService.new(
                                    expense_data: expense_data, 
                                    create_deputy_service: CreateDeputyService.new, 
                                    add_expense_service: AddExpenseService.new
                                  ).call
    end
  end
end
