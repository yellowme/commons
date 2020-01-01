FactoryBot.define do
  factory :employee, class: Employee do
    name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
