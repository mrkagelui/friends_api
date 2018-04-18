FactoryBot.define do
  factory :user do
  	email { Faker::Name.first_name + "@example.com" }
  end
end