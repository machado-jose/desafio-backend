require 'rails_helper'

describe 'Deputy' do
  context '#initialize' do
    before :each do
      @name = Faker::Name.unique.name 
      @ide_register = Faker::Code.unique.npi
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

  context '#add_legislature' do
    before :each do 
      @deputy = create(:deputy)
      @legislature_number = Faker::Code.unique.npi 
      @uf = "rj" 
      @party_acronym = "qpb" 
      @legislature_code = Faker::Code.unique.npi
    end

    it 'Should add new legislature' do
      expect{
        @deputy.add_legislature(
          legislature_number: @legislature_number,
          uf: @uf,
          party_acronym: @party_acronym,
          legislature_code: @legislature_code
        )
        @deputy.save!
      }.to change { Legislature.count }.by(1)
    end

    it 'Should not save legistature with duplicate legislature_code' do
      @deputy.add_legislature(
        legislature_number: @legislature_number,
        uf: @uf,
        party_acronym: @party_acronym,
        legislature_code: @legislature_code
      )
      @deputy.save!
      expect{
        @deputy.add_legislature(
          legislature_number: Faker::Code.unique.npi ,
          uf: 'sc',
          party_acronym: 'ooo',
          legislature_code: @legislature_code
        )
        @deputy.save!
      }.to change { Legislature.count }.by(0)
    end

    context 'Should raise an error' do
      it 'when legislature is invalid' do
        expect{
          @deputy.add_legislature(
            legislature_number: nil,
            uf: @uf,
            party_acronym: @party_acronym,
            legislature_code: @legislature_code
          )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
