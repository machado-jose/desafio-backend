FactoryBot.define do
  factory :legislature do
    deputy { create(:deputy) }
    legislature_number { Faker::Code.unique.npi }
    uf { "rj" }
    party_acronym { "qpb" }
    legislature_code { Faker::Code.unique.npi }
  end
end
