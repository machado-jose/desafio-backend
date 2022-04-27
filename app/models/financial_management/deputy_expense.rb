require './app/services/infrastructure/validator.rb'

class FinancialManagement::DeputyExpense < ApplicationRecord
  belongs_to :legislature
  validates :legislature, presence: { strict: true }
  validates :sub_quota_number, presence: { strict: true }
  validates :sub_quota_description, presence: { strict: true }
  validates :sub_quota_specification_number, presence: { strict: true }
  validates :provider, presence: { strict: true }
  validates :document_number, presence: { strict: true }
  validates :document_type, presence: { strict: true }
  validates :document_value, presence: { strict: true }
  validates :reverse_value, presence: { strict: true }
  validates :net_value, presence: { strict: true }
  validates :expense_month, presence: { strict: true }
  validates :expense_year, presence: { strict: true }
  validates :installment_number, presence: { strict: true }

  enum document_type: {
    invoice: 0,
    receipt: 1,
    expense_abroad: 2,
    not_specified: 3
  }
  
end
