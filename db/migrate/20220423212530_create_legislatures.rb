class CreateLegislatures < ActiveRecord::Migration[6.0]
  def change
    create_table :legislatures do |t|
      t.string :legislature_number
      t.string :uf
      t.string :party_acronym
      t.string :legislature_code
      t.references :deputy, index: true

      t.timestamps
    end
  end
end
