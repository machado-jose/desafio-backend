require './app/services/infrastructure/validator.rb'

class Deputy < ApplicationRecord
  has_many :legislatures 
  
  def custom_initialize(name:, ide_register:, current_uf:)
    change_name(name: name)
    change_ide_register(ide_register: ide_register)
    change_current_uf(current_uf: current_uf)
  end

  private
  def change_name(name:)
    Validator.assert_empty_string name
    self.name = name.upcase
    self
  end

  def change_ide_register(ide_register:)
    Validator.assert_empty_string ide_register
    self.ide_register = ide_register
    self
  end

  def change_current_uf(current_uf:)
    Validator.assert_empty_string current_uf
    self.current_uf = current_uf.upcase
    self
  end
end
