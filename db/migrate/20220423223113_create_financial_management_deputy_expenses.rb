class CreateFinancialManagementDeputyExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_management_deputy_expenses do |t|
      t.references :legislature, null: false, foreign_key: true
      t.string :sub_quota_number
      t.string :sub_quota_description
      t.string :sub_quota_specification_number
      t.string :sub_quota_specification_description
      t.string :provider
      t.string :provider_registration_number
      t.string :document_number
      t.integer :document_type
      t.datetime :issuance_date
      t.decimal :document_value, precision: 8, scale: 2
      t.decimal :reverse_value, precision: 8, scale: 2
      t.decimal :net_value, precision: 8, scale: 2
      t.string :competence
      t.integer :installment_number
      t.string :passager
      t.string :leg_trip
      t.string :batch_number
      t.string :reimbursement_number
      t.decimal :refund_value, precision: 8, scale: 2
      t.string :applicant_identifier

      t.timestamps
    end
  end
end
