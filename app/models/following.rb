class Following < ApplicationRecord
  belongs_to :user_where_it_is_source, class_name: 'User'
  belongs_to :user_where_it_is_audience, class_name: 'User'
  validates_presence_of :user_where_it_is_source, :user_where_it_is_audience
  validates :user_where_it_is_source, uniqueness: { scope: :user_where_it_is_audience_id }
end
