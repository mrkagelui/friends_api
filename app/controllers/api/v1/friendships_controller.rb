class Api::V1::FriendshipsController < ApplicationController
  def create
  	friend_emails = params[:friends]
  	user1 = User.find_by! email: friend_emails[0]
  	user2 = User.find_by! email: friend_emails[1]
    inblock = (Blockade.exists?(user_where_it_is_blocker: user1, user_where_it_is_blockee: user2) || Blockade.exists?(user_where_it_is_blocker: user2, user_where_it_is_blockee: user1))
    if inblock
      render json: { status: :bad_request, error: "one of the users is blocking another", message: 'Friendship not added' }, status: :bad_request
    else 
    	if user1.id < user2.id
    	  Friendship.create!(user_where_it_is_user1: user1, user_where_it_is_user2: user2)
    	else
    	  Friendship.create!(user_where_it_is_user1: user2, user_where_it_is_user2: user1)
    	end
    	render json: { success: true }, status: :created
    end
  end

  def get_friends
    user = User.find_by! email: params[:email]
    friends = user.friends.map { |friend| friend.email }
    render json: { success: true, friends: friends, count: friends.length }, status: :ok
  end

  def get_common_friends
    user_emails = params[:friends]
    common_friends = Array.new
    user_emails.each { |user_email| common_friends = (0 == common_friends.length) ? 
      User.find_by!(email: user_email).friends : common_friends & User.find_by!(email: user_email).friends }
    common_friend_emails = common_friends.map { |e| e.email }
    render json: { success: true, friends: common_friend_emails, count: common_friend_emails.length }, status: :ok
  end
end