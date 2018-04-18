class Api::V1::BlockadesController < ApplicationController
  def create
  	blockee = User.find_by!(email: block_params[:target])
  	blocker = User.find_by!(email: block_params[:requestor])
  	Blockade.create!(user_where_it_is_blockee: blockee, user_where_it_is_blocker: blocker)
  	render json: {"success": true}, status: :ok
  end

  private

  def block_params
  	params.permit(:requestor, :target)
  end
end
