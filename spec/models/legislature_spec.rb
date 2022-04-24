require 'rails_helper'

describe 'Legislature' do
  context 'initialize' do
    before :each do
      @deputy = create(:deputy) 
      @legislature_number = Faker::Code.unique.npi 
      @uf = "rj" 
      @party_acronym = "qpb" 
      @legislature_code = Faker::Code.unique.npi
    end

    it 'Should return valid legislature object' do
      legislature = Legislature.new(
        deputy: @deputy,
        legislature_number: @legislature_number,
        uf: @uf,
        party_acronym: @party_acronym,
        legislature_code: @legislature_code
      )

      expect(legislature.valid?).to be_truthy
      expect(legislature.deputy).to eq(@deputy)
      expect(legislature.legislature_number).to eq(@legislature_number)
      expect(legislature.uf).to eq(@uf.upcase)
      expect(legislature.party_acronym).to eq(@party_acronym.upcase)
      expect(legislature.legislature_code).to eq(@legislature_code)
    end

    it 'Should save legislature on DB' do
      expect { create(:legislature) }.to change { Legislature.count }.by(1)
    end

    context 'Should raise an error' do
      it 'when passing nil deputy' do
        expect{
          Legislature.new(
            deputy: nil,
            legislature_number: @legislature_number,
            uf: @uf,
            party_acronym: @party_acronym,
            legislature_code: @legislature_code
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty legislature_number' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: '',
            uf: @uf,
            party_acronym: @party_acronym,
            legislature_code: @legislature_code
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil legislature_number' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: nil,
            uf: @uf,
            party_acronym: @party_acronym,
            legislature_code: @legislature_code
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty uf' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: @legislature_number,
            uf: '',
            party_acronym: @party_acronym,
            legislature_code: @legislature_code
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil uf' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: @legislature_number,
            uf: nil,
            party_acronym: @party_acronym,
            legislature_code: @legislature_code
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty party_acronym' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: @legislature_number,
            uf: @uf,
            party_acronym: '',
            legislature_code: @legislature_code
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil party_acronym' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: @legislature_number,
            uf: @uf,
            party_acronym: nil,
            legislature_code: @legislature_code
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty party_acronym' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: @legislature_number,
            uf: @uf,
            party_acronym: @party_acronym,
            legislature_code: ''
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil party_acronym' do
        expect{
          Legislature.new(
            deputy: @deputy,
            legislature_number: @legislature_number,
            uf: @uf,
            party_acronym: @party_acronym,
            legislature_code: nil
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
