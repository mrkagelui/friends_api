class Api::V1::UsersController < ApplicationController
  def create
  	user = User.create!(user_params)
  	render json: user, status: :created
  end

  private

  def user_params
  	params.permit(:email)
  end
end
