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

    context 'Should raise an error' do
      it 'when passing empty name' do
        expect{
          Deputy.new.custom_initialize(
            name: '',
            ide_register: @ide_register,
            current_uf: @current_uf
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil name' do
        expect{
          Deputy.new.custom_initialize(
            name: nil,
            ide_register: @ide_register,
            current_uf: @current_uf
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty ide_register' do
        expect{
          Deputy.new.custom_initialize(
            name: @name,
            ide_register: '',
            current_uf: @current_uf
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil ide_register' do
        expect{
          Deputy.new.custom_initialize(
            name: @name,
            ide_register: nil,
            current_uf: @current_uf
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty current_uf' do
        expect{
          Deputy.new.custom_initialize(
            name: @name,
            ide_register: @ide_register,
            current_uf: ''
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil current_uf' do
        expect{
          Deputy.new.custom_initialize(
            name: @name,
            ide_register: @ide_register,
            current_uf: nil
          )
        }.to raise_error(ArgumentError)
      end
    end
  end
end
