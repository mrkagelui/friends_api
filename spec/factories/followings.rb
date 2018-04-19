FactoryBot.define do
  factory :following do
  	association :user_where_it_is_source, factory: :user
  	association :user_where_it_is_audience, factory: :user
  end
end