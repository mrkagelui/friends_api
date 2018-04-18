class Api::V1::FollowingsController < ApplicationController
  def create
  	source = User.find_by!(email: follow_params[:target])
  	audience = User.find_by!(email: follow_params[:requestor])
  	Following.create!(user_where_it_is_source: source, user_where_it_is_audience: audience)
  	render json: {"success": true}, status: :ok
  end
  
  private

  def follow_params
  	params.permit(:requestor, :target)
  end
end
