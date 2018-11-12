FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    smoker { ['Y', 'N'].sample }
    avatar { "#{Rails.root}/spec/fixtures/images/avatar.png" }
  end
end