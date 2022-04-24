FactoryBot.define do
  factory :deputy_expense, class: 'FinancialManagement::DeputyExpense' do
    legislature { create(:legislature) }
    sub_quota_number { Faker::Code.unique.npi }
    sub_quota_description { "any_sub_quota_description" }
    sub_quota_specification_number { Faker::Code.unique.npi }
    sub_quota_specification_description { "any_sub_quota_specification_description" }
    provider { Faker::Name.name }
    provider_registration_number { "999.999.999-99" }
    document_number { Faker::Code.unique.npi }
    document_type { [0, 1, 2].sample }
    issuance_date { DateTime.now - 3.months }
    document_value { 300.to_d }
    reverse_value { 100.to_d }
    net_value { 200.to_d }
    competence { (DateTime.now - 3.months).strftime("%Y-%m") }
    installment_number { 1 }
    passager { Faker::Name.name }
    leg_trip { "any_leg_trip" }
    batch_number { Faker::Code.unique.npi }
    reimbursement_number { Faker::Code.unique.npi }
    refund_value { 200.to_d }
    applicant_identifier { Faker::Code.unique.npi }
  end
end
