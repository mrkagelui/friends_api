FactoryBot.define do
  factory :blockade do
  	association :user_where_it_is_blocker, factory: :user
  	association :user_where_it_is_blockee, factory: :user
  end
end