require 'rails_helper'

describe 'FinancialManagement::FileControl' do
  context '#initialize' do
    before :each do
      @expense_year = DateTime.now.year.to_s 
    end

    it 'Should return valid file_control object' do
      file_control = FinancialManagement::FileControl.new(
        expense_year: @expense_year
      )

      expect(file_control.valid?).to be_truthy
      expect(file_control.expense_year).to eq(@expense_year)
      expect { file_control.save! }.to change { FinancialManagement::FileControl.count }.by(1)
    end

    it 'Should save file_control on DB' do
      expect { create(:file_control) }.to change { FinancialManagement::FileControl.count }.by(1)
    end

    context 'Should raise an error' do
      it 'when passing empty expense_year' do
        expect{
          FinancialManagement::FileControl.new(
            expense_year: ''
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil expense_year' do
        expect{
          FinancialManagement::FileControl.new(
            expense_year: nil
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing invalid formatted expense_year' do
        expect{
          FinancialManagement::FileControl.new(
            expense_year: '20201'
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
