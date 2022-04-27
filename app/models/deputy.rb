class Deputy < ApplicationRecord
  has_many :legislatures, inverse_of: :deputy
  validates :name, presence: { strict: true }
  validates :ide_register, presence: { strict: true }, uniqueness: { strict: true }
  validates :deputy_wallet_number, presence: { strict: true }, uniqueness: { strict: true }
  validates_associated :legislatures, presence: { strict: true }
  after_validation :upcase_deputy_data

  def add_legislature(legislature_number:, uf:, party_acronym:, legislature_code:)
    unless has_legislature?(legislature_code: legislature_code)
      self.legislatures << Legislature.new(
                                            deputy: self,
                                            legislature_number: legislature_number,
                                            uf: uf,
                                            party_acronym: party_acronym,
                                            legislature_code: legislature_code
                                          )
      self.save!
    end
  end

  def all_expense_of_year(year:)
    self.legislatures.map{ |legislature| legislature.all_deputy_expense_of_year(year: year) }.flatten
  end

  def biggest_expense_of_year(year:)
    self.all_expense_of_year(year: year)
        .max{ |deputy_expense_a, deputy_expense_b| deputy_expense_a.net_value <=> deputy_expense_b.net_value}
  end

  def find_legislature(legislature_code:)
    self.legislatures.select{ |legislature| legislature.legislature_code.eql? legislature_code }
                     .first
  end

  def total_expense_of_year(year:)
    self.all_expense_of_year(year: year).reduce(0){ |t, expense| t + expense.net_value }
  end

  private
  def upcase_deputy_data
    self.name = self.name.upcase
  end

  def has_legislature?(legislature_code:)
    self.find_legislature(legislature_code: legislature_code).present?
  end
end
