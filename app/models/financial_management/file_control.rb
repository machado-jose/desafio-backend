class FinancialManagement::FileControl < ApplicationRecord
  validates :expense_year, presence: { strict: true }, format: { with: /\A\d{4}\z/, strict: true}
end
