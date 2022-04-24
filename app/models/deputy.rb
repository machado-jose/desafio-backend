class Deputy < ApplicationRecord
  has_many :legislatures
  validates :name, presence: { strict: true }
  validates :ide_register, presence: { strict: true }, uniqueness: true
  validates :current_uf, presence: { strict: true }
  validates_associated :legislatures, presence: { strict: true }
  after_validation :upcase_deputy_data

  private
  def upcase_deputy_data
    self.name = self.name.upcase
    self.current_uf = self.current_uf.upcase
  end
end
