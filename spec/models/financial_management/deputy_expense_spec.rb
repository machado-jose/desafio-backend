require 'rails_helper'

describe 'FinancialManagement::DeputyExpense' do
  context '#call' do
    before :each do
      @legislature = create(:legislature) 
      @sub_quota_number = Faker::Code.npi 
      @sub_quota_description = "any_sub_quota_description" 
      @sub_quota_specification_number = Faker::Code.npi 
      @sub_quota_specification_description = "any_sub_quota_specification_description" 
      @provider = Faker::Name.name 
      @provider_registration_number = "999.999.999-99" 
      @document_number = Faker::Code.npi 
      @document_type = 0
      @issuance_date = DateTime.now - 3.months 
      @document_value = 300.to_d 
      @reverse_value = 100.to_d 
      @net_value = 200.to_d 
      @competence = (DateTime.now - 3.months).strftime("%Y-%m") 
      @installment_number = 1 
      @passager = Faker::Name.name 
      @leg_trip = "any_leg_trip" 
      @batch_number = Faker::Code.npi 
      @reimbursement_number = Faker::Code.npi 
      @refund_value = 200.to_d 
      @applicant_identifier = Faker::Code.npi
    end

    it 'Should return valid deputy_expense object' do
      deputy_expense = FinancialManagement::DeputyExpense.new.custom_initialize(
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
        competence: @competence,
        installment_number: @installment_number, 
        passager: @passager, 
        leg_trip: @leg_trip, 
        batch_number: @batch_number, 
        reimbursement_number: @reimbursement_number, 
        refund_value: @refund_value, 
        applicant_identifier: @applicant_identifier
      )

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
      expect(deputy_expense.competence).to eq(@competence)
      expect(deputy_expense.installment_number).to eq(@installment_number)
      expect(deputy_expense.passager).to eq(@passager)
      expect(deputy_expense.leg_trip).to eq(@leg_trip)
      expect(deputy_expense.batch_number).to eq(@batch_number)
      expect(deputy_expense.reimbursement_number).to eq(@reimbursement_number)
      expect(deputy_expense.refund_value).to eq(@refund_value)
      expect(deputy_expense.applicant_identifier).to eq(@applicant_identifier)
    end

    it 'Should save deputy_expense on DB' do
      expect { create(:deputy_expense) }.to change { FinancialManagement::DeputyExpense.count }.by(1)
    end

    context 'Should raise an error' do
      it 'when passing nil legislature' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty sub_quota_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil sub_quota_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty sub_quota_description' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil sub_quota_description' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty sub_quota_specification_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil sub_quota_specification_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty sub_quota_specification_description' do
        expect{
          Legislature.new.custom_initialize(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: '', 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil sub_quota_specification_description' do
        expect{
          Legislature.new.custom_initialize(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: nil, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: @document_type, 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty provider' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil provider' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty provider_registration_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil provider_registration_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty document_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil document_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty document_type' do
        expect{
          Legislature.new.custom_initialize(
            legislature: @legislature, 
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: @document_number,
            document_type: '', 
            issuance_date: @issuance_date, 
            document_value: @document_value, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil document_type' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty issuance_date' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil issuance_date' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing float document_value' do
        expect{
          Legislature.new.custom_initialize(
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
            document_value: 300.0, 
            reverse_value: @reverse_value, 
            net_value: @net_value, 
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing float reverse_value' do
        expect{
          Legislature.new.custom_initialize(
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
            reverse_value: 300.0, 
            net_value: @net_value, 
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing float net_value' do
        expect{
          Legislature.new.custom_initialize(
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
            net_value: 300.0, 
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty competence' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: '',
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil competence' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: nil,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil installment_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: nil, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty passager' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: '', 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty leg_trip' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: '', 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end 

      it 'when passing empty batch_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: '', 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil batch_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: nil, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty reimbursement_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: '', 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil reimbursement_number' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: nil, 
            refund_value: @refund_value, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing float refund_value' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: 300.0, 
            applicant_identifier: @applicant_identifier
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing empty applicant_identifier' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: ''
          )
        }.to raise_error(ArgumentError)
      end

      it 'when passing nil applicant_identifier' do
        expect{
          Legislature.new.custom_initialize(
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
            competence: @competence,
            installment_number: @installment_number, 
            passager: @passager, 
            leg_trip: @leg_trip, 
            batch_number: @batch_number, 
            reimbursement_number: @reimbursement_number, 
            refund_value: @refund_value, 
            applicant_identifier: nil
          )
        }.to raise_error(ArgumentError)
      end
    end
  end
end
