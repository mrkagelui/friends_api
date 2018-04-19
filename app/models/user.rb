class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A(?:[\w+\-].?)+@[a-z\d\-]+(?:\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}

  has_many :friendships_as_user1, class_name: "Friendship", foreign_key: "user_where_it_is_user1_id", dependent: :destroy
  has_many :friendships_as_user2, class_name: "Friendship", foreign_key: "user_where_it_is_user2_id", dependent: :destroy
  has_many :followings_as_source, class_name: "Following", foreign_key: "user_where_it_is_source_id", dependent: :destroy
  has_many :followings_as_audience, class_name: "Following", foreign_key: "user_where_it_is_audience_id", dependent: :destroy
  has_many :blockades_as_blocker, class_name: "Blockade", foreign_key: "user_where_it_is_blocker_id", dependent: :destroy
  has_many :blockades_as_blockee, class_name: "Blockade", foreign_key: "user_where_it_is_blockee_id", dependent: :destroy

  def friends
    self.friendships_as_user1.collect(&:user_where_it_is_user2) | self.friendships_as_user2.collect(&:user_where_it_is_user1)
  end

  def blockers
    self.blockades_as_blockee.collect(&:user_where_it_is_blocker)
  end

  def followers
    self.followings_as_source.collect(&:user_where_it_is_audience)
  end
end
