class AddIndexToFinancialManagementDeputyExpense < ActiveRecord::Migration[6.0]
  def change
    add_index :financial_management_deputy_expenses, :document_number, unique: true
    add_index :financial_management_deputy_expenses, :document_url, unique: true
  end
end
