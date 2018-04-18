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
end