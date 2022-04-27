class AddIndexToFinancialManagementDeputyExpense < ActiveRecord::Migration[6.0]
  def change
    add_index :financial_management_deputy_expenses, [:legislature_id, :document_number], unique: true, name: 'index_fm_deputy_expenses_on_legisl_id_and_doc_number' 
  end
end
