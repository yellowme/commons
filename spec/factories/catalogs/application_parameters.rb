FactoryBot.define do
  factory :application_parameter, :class => Catalogs::ApplicationParameter do
    name { Faker::Name.name }
    value { Faker::Number.number(digits: 5) }
  end
end
