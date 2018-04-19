FactoryBot.define do
  factory :friendship do
  	association :user_where_it_is_user1, factory: :user
  	association :user_where_it_is_user2, factory: :user
  end
end