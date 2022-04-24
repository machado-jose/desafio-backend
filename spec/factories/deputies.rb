FactoryBot.define do
  factory :deputy do
    name { Faker::Name.unique.name }
    ide_register { "99999" }
    current_uf { "rj" }
  end
end
