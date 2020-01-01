FactoryBot.define do
  factory :user, class: User do
    name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sex { [Commons::Concerns::Attributes::Sex::FEMALE, Commons::Concerns::Attributes::Sex::MALE].sample }
  end
end
