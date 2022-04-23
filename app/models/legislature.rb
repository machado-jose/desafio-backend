require './app/services/infrastructure/validator.rb'

class Legislature < ApplicationRecord
  belongs_to :deputy
  
  def custom_initialize(deputy:, legislature_number:, uf:, party_acronym:, legislature_code:)
    change_deputy(deputy: deputy)
    change_legislature_number(legislature_number: legislature_number)
    change_uf(uf: uf)
    change_party_acronym(party_acronym: party_acronym)
    change_legislature_code(legislature_code: legislature_code)
  end

  private
  def change_deputy(deputy:)
    Validator.assert_object_class_type deputy, Deputy
    self.deputy = deputy
    self
  end

  def change_legislature_number(legislature_number:)
    Validator.assert_empty_string legislature_number
    self.legislature_number = legislature_number
    self
  end

  def change_uf(uf:)
    Validator.assert_empty_string uf
    self.uf = uf.upcase
    self
  end

  def change_party_acronym(party_acronym:)
    Validator.assert_empty_string party_acronym
    self.party_acronym = party_acronym.upcase
    self
  end

  def change_legislature_code(legislature_code:)
    Validator.assert_empty_string legislature_code
    self.legislature_code = legislature_code
    self
  end
end
