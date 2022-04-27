require 'rails_helper'

describe 'Legislature' do
  context '#initialize' do
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
      expect{
        legislature.save!
      }.to change { Legislature.count }.by(1)
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

      it 'when passing empty legislature_code' do
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

      it 'when passing nil legislature_code' do
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

      it 'when duplicate legislature to one deputy' do
        legislature = Legislature.new(
                                        deputy: @deputy,
                                        legislature_number: @legislature_number,
                                        uf: @uf,
                                        party_acronym: @party_acronym,
                                        legislature_code: @legislature_code
                                      )
        legislature.save!
        legislature_2 = Legislature.new(
                                        deputy: @deputy,
                                        legislature_number: @legislature_number,
                                        uf: @uf,
                                        party_acronym: @party_acronym,
                                        legislature_code: @legislature_code
                                      )
        expect {
          legislature_2.save!
        }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end

  context '#add_deputy_expense' do
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

    it 'Should add new deputy expense' do
      expect{
        @legislature.add_deputy_expense(
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
        @legislature.save!
      }.to change { FinancialManagement::DeputyExpense.count }.by(1)
    end

    context 'Should raise an error' do
      it 'when legislature is invalid' do
        expect{
          @legislature.add_deputy_expense(
            sub_quota_number: @sub_quota_number, 
            sub_quota_description: @sub_quota_description, 
            sub_quota_specification_number: @sub_quota_specification_number, 
            sub_quota_specification_description: @sub_quota_specification_description, 
            provider: @provider, 
            provider_registration_number: @provider_registration_number, 
            document_number: Faker::Code.unique.npi,
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
          )
        }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end

  context '#all_deputy_expense_of_year' do
    before :each do
      @legislature = create(:legislature)
    end

    it 'Should return all deputy expense of specific year' do
      deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      deputy_expense_2 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      deputy_expense_3 = create(:deputy_expense, legislature: @legislature, expense_year: '2020')
      @legislature.reload
      all_deputy_expenses = @legislature.all_deputy_expense_of_year(year: '2021')
      expect(all_deputy_expenses.count).to eq(2)
      expect(all_deputy_expenses).to include(deputy_expense_1)
      expect(all_deputy_expenses).to include(deputy_expense_2)
    end

    it 'Should return empty array' do
      deputy_expense_1 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      deputy_expense_2 = create(:deputy_expense, legislature: @legislature, expense_year: '2021')
      @legislature.reload
      expect(@legislature.all_deputy_expense_of_year(year: '2020').empty?).to be_truthy
    end

    context 'Should raise an error' do
      it 'if passing empty year' do
        expect{
          @legislature.all_deputy_expense_of_year(year: '')
        }.to raise_error(ArgumentError)
      end

      it 'if passing integer year' do
        expect{
          @legislature.all_deputy_expense_of_year(year: 2021)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
