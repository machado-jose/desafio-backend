require 'rails_helper'

describe 'Deputy' do
  context '#custom_initialize' do
    before :each do
      @name = Faker::Name.unique.name 
      @ide_register = "99999" 
      @current_uf = "rj" 
    end

    it 'Should return valid deputy object' do
      deputy = Deputy.new.custom_initialize(
        name: @name,
        ide_register: @ide_register,
        current_uf: @current_uf
      )

      expect(deputy.name).to eq(@name.upcase)
      expect(deputy.ide_register).to eq(@ide_register)
      expect(deputy.current_uf).to eq(@current_uf.upcase)
    end

    it 'Should save deputy on DB' do
      expect { create(:deputy) }.to change { Deputy.count }.by(1)
    end
  end
end
