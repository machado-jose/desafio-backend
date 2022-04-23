FactoryBot.define do
  factory :deputy do
    name { Faker::Name.unique.name }
    ide_register { "99999" }
    current_uf { "rj" }

    initiliaze_with {
      new.custom_initialize(
        name: name,
        ide_register: ide_register,
        current_uf: current_uf
      )
    }
  end
end
