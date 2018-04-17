class Api::V1::UsersController < ApplicationController
  def create
  	user = User.create!(user_params)
  	render json: user, status: :created
  end

  def get_friends
    user = User.find_by! email: user_params[:email]
    puts "user id is #{user.id}"
    friends = user.friends.map { |friend_id| User.find(friend_id).email }
    puts "#{user.friends.length} is here"
    render json: { success: true, friends: friends, count: friends.length }, status: :ok
  end

  private

  def user_params
  	params.permit(:email)
  end
end
