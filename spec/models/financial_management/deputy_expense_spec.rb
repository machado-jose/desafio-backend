require 'rails_helper'

describe 'FinancialManagement::DeputyExpense' do
  context '#new' do
    before :each do
      @legislature = create(:legislature) 
      @sub_quota_number = Faker::Code.unique.npi 
      @sub_quota_description = "any_sub_quota_description" 
      @sub_quota_specification_number = Faker::Code.unique.npi 
      @sub_quota_specification_description = "any_sub_quota_specification_description" 
      @provider = Faker::Name.name 
      @provider_registration_number = "999.999.999-99" 
      @document_number = Faker::Code.unique.npi 
      @document_type = 0
      @issuance_date = DateTime.now - 3.months 
      @document_value = 300.to_d 
      @reverse_value = 100.to_d 
      @net_value = 200.to_d 
      @expense_month = (DateTime.now - 3.months).strftime("%m") 
      @expense_year = (DateTime.now - 3.months).strftime("%Y") 
      @installment_number = 1 
      @passager = Faker::Name.name 
      @leg_trip = "any_leg_trip" 
      @batch_number = Faker::Code.unique.npi 
      @reimbursement_number = Faker::Code.unique.npi 
      @refund_value = 200.to_d 
      @applicant_identifier = Faker::Code.unique.npi
      @document_url = Faker::Internet.unique.url
    end

    it 'Should return valid deputy_expense object' do
      deputy_expense = FinancialManagement::DeputyExpense.new(
        legislature: @legislature, 
        sub_quota_number: @sub_quota_number, 
        sub_quota_description: @sub_quota_description, 
        sub_quota_specification_number: @sub_quota_specification_number, 
        sub_quota_specification_description: @sub_quota_specification_description, 
        provider: @provider, 
        provider_registration_number: @provider_registration_number, 
        document_number: @document_number,
        document_type: @document_type, 
        issuance_date: @issuance_date, 
        document_value: @document_value, 
        reverse_value: @reverse_value, 
        net_value: @net_value, 
        expense_month: @expense_month,
        expense_year: @expense_year,
        installment_number: @installment_number, 
        passager: @passager, 
        leg_trip: @leg_trip, 
        batch_number: @batch_number, 
        reimbursement_number: @reimbursement_number, 
        refund_value: @refund_value, 
        applicant_identifier: @applicant_identifier,
        document_url: @document_url
      )

      expect(deputy_expense.valid?).to be_truthy
      expect(deputy_expense.legislature).to eq(@legislature)
      expect(deputy_expense.sub_quota_number).to eq(@sub_quota_number)
      expect(deputy_expense.sub_quota_description).to eq(@sub_quota_description)
      expect(deputy_expense.sub_quota_specification_number).to eq(@sub_quota_specification_number)
      expect(deputy_expense.sub_quota_specification_description).to eq(@sub_quota_specification_description)
      expect(deputy_expense.provider).to eq(@provider)
      expect(deputy_expense.provider_registration_number).to eq(@provider_registration_number)
      expect(deputy_expense.document_number).to eq(@document_number)
      expect(deputy_expense.invoice?).to be_truthy
      expect(deputy_expense.issuance_date).to eq(@issuance_date)
      expect(deputy_expense.document_value).to eq(@document_value)
      expect(deputy_expense.net_value).to eq(@net_value)
      expect(deputy_expense.expense_month).to eq(@expense_month)
      expect(deputy_expense.expense_year).to eq(@expense_year)
      expect(deputy_expense.installment_number).to eq(@installment_number)
      expect(deputy_expense.passager).to eq(@passager)
      expect(deputy_expense.leg_trip).to eq(@leg_trip)
      expect(deputy_expense.batch_number).to eq(@batch_number)
      expect(deputy_expense.reimbursement_number).to eq(@reimbursement_number)
      expect(deputy_expense.refund_value).to eq(@refund_value)
      expect(deputy_expense.applicant_identifier).to eq(@applicant_identifier)
      expect(deputy_expense.document_url).to eq(@document_url)
    end

    it 'Should save deputy_expense on DB' do
      expect { create(:deputy_expense) }.to change { FinancialManagement::DeputyExpense.count }.by(1)
    end

    context 'Should raise an error' do
      it 'when passing nil legislature' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: nil, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty sub_quota_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: '', 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil sub_quota_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: nil, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty sub_quota_description' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: '', 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil sub_quota_description' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: nil, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty sub_quota_specification_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: '', 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil sub_quota_specification_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: nil, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty provider' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: '', 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil provider' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: nil, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty provider_registration_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: '', 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil provider_registration_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: nil, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty document_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: '',
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil document_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: nil,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing invalid document_type' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: 9, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil document_type' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: nil, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty issuance_date' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: '', 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil issuance_date' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: nil, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil document_value' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: nil, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil reverse_value' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: nil, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil net_value' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: nil, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty expense_month' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: '',
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil expense_month' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: nil,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty expense_year' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: '',
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil expense_year' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: nil,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil installment_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: nil, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty batch_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: '', 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil batch_number' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: nil, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing empty applicant_identifier' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: '',
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end

      it 'when passing nil applicant_identifier' do
        expect{
          FinancialManagement::DeputyExpense.new(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            expense_month: @expense_month,
            expense_year: @expense_year,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: nil,
            document_url: @document_url
          ).valid?
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
