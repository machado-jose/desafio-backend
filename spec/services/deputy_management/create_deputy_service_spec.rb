require 'rails_helper'
require './app/services/deputy_management/create_deputy_service.rb'

describe 'CreateDeputyService' do
  context '#call' do
    before :each do
      @name = Faker::Name.unique.name 
      @ide_register = Faker::Code.unique.npi
      @deputy_wallet_number = Faker::Code.unique.npi 
    end

    it 'Should create deputy' do
      deputy = CreateDeputyService.new.call(
                                        name: @name,
                                        ide_register: @ide_register,
                                        deputy_wallet_number: @deputy_wallet_number
                                      )
      expect(deputy.name).to eq(@name.upcase)
      expect(deputy.ide_register).to eq(@ide_register)
      expect(deputy.deputy_wallet_number).to eq(@deputy_wallet_number)
    end

    context 'Should raise an error' do
      it 'when passing empty name' do
        expect{
          CreateDeputyService.new.call(
                                    name: '',
                                    ide_register: @ide_register,
                                    deputy_wallet_number: @deputy_wallet_number
                                  )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil name' do
        expect{
          CreateDeputyService.new.call(
                                    name: nil,
                                    ide_register: @ide_register,
                                    deputy_wallet_number: @deputy_wallet_number
                                  )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty ide_register' do
        expect{
          CreateDeputyService.new.call(
                                    name: @name,
                                    ide_register: '',
                                    deputy_wallet_number: @deputy_wallet_number
                                  )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil ide_register' do
        expect{
          CreateDeputyService.new.call(
                                    name: @name,
                                    ide_register: nil,
                                    deputy_wallet_number: @deputy_wallet_number
                                  )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty deputy_wallet_number' do
        expect{
          CreateDeputyService.new.call(
                                    name: @name,
                                    ide_register: @ide_register,
                                    deputy_wallet_number: ''
                                  )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil deputy_wallet_number' do
        expect{
          CreateDeputyService.new.call(
                                    name: @name,
                                    ide_register: @ide_register,
                                    deputy_wallet_number: nil
                                  )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
