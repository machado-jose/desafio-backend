class AddLegislatureCodeYearIndexToLegislature < ActiveRecord::Migration[6.0]
  def change
    add_index :legislatures, [:deputy_id, :legislature_code], unique: true
  end
end
