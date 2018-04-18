class Api::V1::BlockadesController < ApplicationController
  def create
  	blockee = User.find_by!(email: follow_params[:target])
  	blocker = User.find_by!(email: follow_params[:requestor])
  	Blockade.create!(user_where_it_is_blockee: blockee, user_where_it_is_blocker: blocker)
  	render json: {"success": true}, status: :ok
  end

  private

  def follow_params
  	params.permit(:requestor, :target)
  end
end
