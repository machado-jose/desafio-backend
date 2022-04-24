FactoryBot.define do
  factory :deputy do
    name { Faker::Name.unique.name }
    ide_register { Faker::Code.unique.npi }
    current_uf { "rj" }
  end
end
