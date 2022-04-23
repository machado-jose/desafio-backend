FactoryBot.define do
  factory :legislature do
    deputy { create(:deputy) }
    legislature_number { "9999" }
    uf { "rj" }
    party_acronym { "qpb" }
    legislature_code { "8888" }

    initialize_with {
      new.custom_initialize(
        deputy: deputy,
        legislature_number: legislature_number,
        uf: uf,
        party_acronym: party_acronym,
        legislature_code: legislature_code
      )
    }
  end
end
