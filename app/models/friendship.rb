class Friendship < ApplicationRecord
  belongs_to :user_where_it_is_user1, class_name: 'User'
  belongs_to :user_where_it_is_user2, class_name: 'User'
  validates_presence_of :user_where_it_is_user1, :user_where_it_is_user2
  validates :user_where_it_is_user1, uniqueness: { scope: [:user_where_it_is_user2_id] }
end
