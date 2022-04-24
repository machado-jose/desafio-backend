class AddDocumentUrlToFinancialManagementDeputyExpense < ActiveRecord::Migration[6.0]
  def change
    add_column :financial_management_deputy_expenses, :document_url, :string
  end
end
