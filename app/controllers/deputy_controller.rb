require './app/services/deputy_management/register_deputies_expenses/extract_expense_data_from_csv_service.rb'
require './app/services/infrastructure/parse_csv_file_service.rb'
require './app/services/deputy_management/register_deputies_expenses/create_file_control_service.rb'

class DeputyController < ApplicationController
  def index
  end
  
  def submit_csv
    begin
      parse_csv_file_service = ParseCsvFileService.new(file: params[:file])
      expense_data = ExtractExpenseDataFromCsvService.new(
                                                            parse_csv_file_service: parse_csv_file_service, 
                                                            uf: "RJ"
                                                          ).call
      redirect_to root_path, { flash: { notice: "Arquivo não contém dados!" } } and return if expense_data.empty?
      expense_year = expense_data.values
                                .first
                                .first["numAno"]
      unless FinancialManagement::FileControl.find_by(expense_year: expense_year).present?
        expense_data = expense_data.sort_by{ |_, values| values.count }.to_h
        Thread.new do
          RegisterDeputyExpenseJob.perform_later(expense_data)
        end
        redirect_to deputy_rank_path, { flash: { notice: "Os dados estão sendo armazenados!" } }
      else  
        redirect_to root_path, { flash: { notice: "Esse arquivo já foi submetido!" } }
      end
    rescue => e  
      redirect_to root_path, { flash: { notice: "Ocorreu um erro!" } }
    end
  end

  def rank
    @deputies = Deputy.includes(:legislatures).all
  end

  def details
    @deputy = Deputy.includes(:legislatures).find_by(id: params[:id])
    redirect_to root_path and return unless @deputy.present?
    @expenses_by_month = @deputy.expenses_for_every_month_of_year(year: '2021')
  end
end
