class CreateFinancialManagementFileControls < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_management_file_controls do |t|
      t.string :expense_year

      t.timestamps
    end
  end
end
