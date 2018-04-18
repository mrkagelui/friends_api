class Api::V1::FriendshipsController < ApplicationController
  def create
  	friend_emails = params[:friends]
  	user1 = User.find_by! email: friend_emails[0]
  	user2 = User.find_by! email: friend_emails[1]
  	if user1.id < user2.id
  	  Friendship.create!(user_where_it_is_user1: user1, user_where_it_is_user2: user2)
  	else
  	  Friendship.create!(user_where_it_is_user1: user2, user_where_it_is_user2: user1)
  	end
  	render json: { success: true }, status: :created
  end

  def get_friends
    user = User.find_by! email: params[:email]
    friends = user.friends.map { |friend_id| User.find(friend_id).email }
    render json: { success: true, friends: friends, count: friends.length }, status: :ok
  end

  def get_common_friends
    user_emails = params[:friends]
    common_friend_ids = Array.new
    user_emails.each { |user_email| common_friend_ids = (0 == common_friend_ids.length) ? 
      User.find_by!(email: user_email).friends : common_friend_ids & User.find_by!(email: user_email).friends }
    common_friend_emails = common_friend_ids.map { |e| User.find(e).email }
    render json: { success: true, friends: common_friend_emails, count: common_friend_emails.length }, status: :ok
  end
end