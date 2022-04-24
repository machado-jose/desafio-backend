require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'

class DeputyController < ApplicationController
  def submit_csv
    expense_data = ExtractExpenseDataFromCsvService.new(file: params[:file], uf: params[:uf]).call
  end
end
