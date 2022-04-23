FactoryBot.define do
  factory :deputy_expense, class: 'FinancialManagement::DeputyExpense' do
    legislature { create(:legislature) }
    sub_quota_number { Faker::Code.npi }
    sub_quota_description { "any_sub_quota_description" }
    sub_quota_specification_number { Faker::Code.npi }
    sub_quota_specification_description { "any_sub_quota_specification_description" }
    provider { Faker::Name.name }
    provider_registration_number { "999.999.999-99" }
    document_number { Faker::Code.npi }
    document_type { [0, 1, 2].sample }
    issuance_date { DateTime.now - 3.months }
    document_value { 300.to_d }
    reverse_value { 100.to_d }
    net_value { 200.to_d }
    competence { (DateTime.now - 3.months).strftime("%Y-%m") }
    installment_number { 1 }
    passager { Faker::Name.name }
    leg_trip { "any_leg_trip" }
    batch_number { Faker::Code.npi }
    reimbursement_number { Faker::Code.npi }
    refund_value { 200.to_d }
    applicant_identifier { Faker::Code.npi }

    initialize_with {
      new.custom_initialize(
        legislature: legislature, 
        sub_quota_number: sub_quota_number, 
        sub_quota_description: sub_quota_description, 
        sub_quota_specification_number: sub_quota_specification_number, 
        sub_quota_specification_description: sub_quota_specification_description, 
        provider: provider, 
        provider_registration_number: provider_registration_number, 
        document_number: document_number,
        document_type: document_type, 
        issuance_date: issuance_date, 
        document_value: document_value, 
        reverse_value: reverse_value, 
        net_value: net_value, 
        competence: competence,
        installment_number: installment_number, 
        passager: passager, 
        leg_trip: leg_trip, 
        batch_number: batch_number, 
        reimbursement_number: reimbursement_number, 
        refund_value: refund_value, 
        applicant_identifier: applicant_identifier
      )
    }
  end
end
