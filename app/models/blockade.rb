class Blockade < ApplicationRecord
  belongs_to :user_where_it_is_blocker, class_name: 'User'
  belongs_to :user_where_it_is_blockee, class_name: 'User'
  validates_presence_of :user_where_it_is_blocker, :user_where_it_is_blockee
  validates :user_where_it_is_blocker, uniqueness: { scope: :user_where_it_is_blockee_id }
end
