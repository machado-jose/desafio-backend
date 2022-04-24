require 'rails_helper'

describe 'Deputy' do
  context '' do
    before :each do
      @name = Faker::Name.unique.name 
      @ide_register = "99999" 
      @current_uf = "rj" 
    end

    it 'Should return valid deputy object' do
      deputy = Deputy.new(
        name: @name,
        ide_register: @ide_register,
        current_uf: @current_uf
      )

      expect(deputy.valid?).to be_truthy
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
          Deputy.new(
            name: '',
            ide_register: @ide_register,
            current_uf: @current_uf
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil name' do
        expect{
          Deputy.new(
            name: nil,
            ide_register: @ide_register,
            current_uf: @current_uf
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty ide_register' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: '',
            current_uf: @current_uf
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil ide_register' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: nil,
            current_uf: @current_uf
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty current_uf' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: @ide_register,
            current_uf: ''
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil current_uf' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: @ide_register,
            current_uf: nil
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
