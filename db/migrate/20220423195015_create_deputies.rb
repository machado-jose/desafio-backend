class CreateDeputies < ActiveRecord::Migration[6.0]
  def change
    create_table :deputies do |t|
      t.string :name
      t.string :ide_register
      t.string :current_uf

      t.timestamps
    end
  end
end
