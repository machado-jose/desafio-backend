require './app/services/infrastructure/validator.rb'

class Legislature < ApplicationRecord
  belongs_to :deputy
  has_many :deputy_expenses, class_name: 'FinancialManagement::DeputyExpense'
  validates :deputy, presence: { strict: true }
  validates :legislature_number, presence: { strict: true }
  validates :uf, presence: { strict: true }
  validates :party_acronym, presence: { strict: true }
  validates :legislature_code, presence: { strict: true }
  validates_associated :deputy_expenses, presence: { strict: true }
  after_validation :upcase_legislature_data

  private
  def upcase_legislature_data
    self.party_acronym = self.party_acronym.upcase
    self.uf = self.uf.upcase
  end
end
