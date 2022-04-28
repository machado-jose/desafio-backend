require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/create_file_control_service.rb'

describe 'CreateFileControlService' do
  context '#call' do
    it 'Should return true when create object' do
      response = CreateFileControlService.new(expense_year: '2021').call
      expect(response).to be_truthy
    end

    it 'Should change FinancialManagement::FileControl DB' do
      expect{
        CreateFileControlService.new(expense_year: '2021').call
      }.to change{ FinancialManagement::FileControl.count }.by(1)
    end

    it 'Should return false when exists object' do
      expense_year = '2021'
      create(:file_control, expense_year: expense_year)
      response = CreateFileControlService.new(expense_year: expense_year).call
      expect(response).to be_falsey
    end

    it 'Should return false when invalid expense year' do
      response = CreateFileControlService.new(expense_year: '20211').call
      expect(response).to be_falsey
    end
  end
end
