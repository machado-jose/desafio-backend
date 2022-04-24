require 'rails_helper'

describe 'Deputy' do
  context '#initialize' do
    before :each do
      @name = Faker::Name.unique.name 
      @ide_register = Faker::Code.unique.npi
      @deputy_wallet_number = Faker::Code.unique.npi 
    end

    it 'Should return valid deputy object' do
      deputy = Deputy.new(
        name: @name,
        ide_register: @ide_register,
        deputy_wallet_number: @deputy_wallet_number
      )

      expect(deputy.valid?).to be_truthy
      expect(deputy.name).to eq(@name.upcase)
      expect(deputy.ide_register).to eq(@ide_register)
      expect(deputy.deputy_wallet_number).to eq(@deputy_wallet_number)
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
            deputy_wallet_number: @deputy_wallet_number
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil name' do
        expect{
          Deputy.new(
            name: nil,
            ide_register: @ide_register,
            deputy_wallet_number: @deputy_wallet_number
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty ide_register' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: '',
            deputy_wallet_number: @deputy_wallet_number
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil ide_register' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: nil,
            deputy_wallet_number: @deputy_wallet_number
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty deputy_wallet_number' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: @ide_register,
            deputy_wallet_number: ''
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil deputy_wallet_number' do
        expect{
          Deputy.new(
            name: @name,
            ide_register: @ide_register,
            deputy_wallet_number: nil
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

  context '#all_expense_of_year' do
    before :each do
      @deputy = create(:deputy)
      @legislature = create(:legislature, deputy: @deputy)
    end

    it 'Should return all deputy expense of specific year' do
      deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      deputy_expense_2 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      deputy_expense_3 = create(:deputy_expense, legislature: @legislature, expense_year: '2020')
      @deputy.reload
      all_deputy_expenses = @deputy.all_expense_of_year(year: '2021')
      expect(all_deputy_expenses.count).to eq(2)
      expect(all_deputy_expenses).to include(deputy_expense_1)
      expect(all_deputy_expenses).to include(deputy_expense_2)
    end

    it 'Should return empty array' do
      deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      deputy_expense_2 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      @deputy.reload
      expect(@deputy.all_expense_of_year(year: '2020').empty?).to be_truthy
    end

    context 'Should raise an error' do
      before :each do
        deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
        @deputy.reload
      end

      it 'if passing empty year' do
        expect{
          @deputy.all_expense_of_year(year: '')
        }.to raise_error(ArgumentError)
      end

      it 'if passing integer year' do
        expect{
          @deputy.all_expense_of_year(year: 2021)
        }.to raise_error(ArgumentError)
      end
    end
  end

  context '#biggest_expense_of_year' do
    before :each do
      @deputy = create(:deputy)
      @legislature = create(:legislature, deputy: @deputy)
    end

    it 'Should return biggest deputy expense of year' do
      deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021', net_value: 200.0)
      deputy_expense_2 = create(:deputy_expense, legislature: @legislature, expense_year: '2021', net_value: 600.0)
      deputy_expense_3 = create(:deputy_expense, legislature: @legislature, expense_year: '2021', net_value: 400.0)
      deputy_expense_4 = create(:deputy_expense, legislature: @legislature, expense_year: '2020', net_value: 1000.0)
      @deputy.reload
      expect(@deputy.biggest_expense_of_year(year: '2021')).to eq(deputy_expense_2)
    end

    it 'Should return nil' do
      deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021', net_value: 200.0)
      deputy_expense_2 = create(:deputy_expense, legislature: @legislature, expense_year: '2021', net_value: 600.0)
      expect(@deputy.biggest_expense_of_year(year: '2021').nil?).to be_truthy
    end

    context 'Should raise an error' do
      before :each do
        deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
        @deputy.reload
      end

      it 'if passing empty year' do
        expect{
          @deputy.all_expense_of_year(year: '')
        }.to raise_error(ArgumentError)
      end

      it 'if passing integer year' do
        expect{
          @deputy.all_expense_of_year(year: 2021)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
