FactoryBot.define do
  factory :deputy do
    name { Faker::Name.unique.name }
    ide_register { Faker::Code.unique.npi }
    deputy_wallet_number { Faker::Code.unique.npi }
  end
end
