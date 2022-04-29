require './app/services/deputy_management/register_deputies_expenses/analyze_expense_data_service.rb'
require './app/services/deputy_management/create_deputy_service.rb'
require './app/services/deputy_management/register_deputies_expenses/add_expense_service.rb'

class RegisterDeputyExpenseJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(expense_data)
    transaction_success = false
    ActiveRecord::Base.transaction do
      expense_data.each do |ideCadastro, deputy_expense_list|
        deputy_name = deputy_expense_list.first["txNomeParlamentar"]
        AnalyzeExpenseDataService.new(
                                      ide_register: ideCadastro, 
                                      deputy_expense_list: deputy_expense_list,
                                      create_deputy_service: CreateDeputyService.new, 
                                      add_expense_service: AddExpenseService.new
                                    ).call
        cable_ready["RegisterExpenseDeputyChannel"].set_dataset_property(
          name:       "message",   
          selector:   "#message",   
          value:      "#{deputy_name}",
        )
        cable_ready.broadcast
      end
      transaction_success = true
    end
    expense_year = expense_data.values
                               .first
                               .first["numAno"]
    CreateFileControlService.new(expense_year: expense_year).call if transaction_success
  end
end
