class Api::V1::Update::ReceiversController < ApplicationController
  def retrieve
    sender = User.find_by! email: update_params[:sender]
    friend_ids = sender.friends
    follower_ids = sender.followers
    mentioned_emails = update_params[:text].scan(
    	/\b([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6})\b/).flatten
    mentioned_ids = mentioned_emails.map { |e| User.find_by(email: e).id }
    blocker_ids = sender.blockers
    receiver_ids = (friend_ids | follower_ids | mentioned_ids) - blocker_ids
    receiver_emails = receiver_ids.map { |e| User.find(e).email }
    render json: { success: true, recipients: receiver_emails }, status: :ok
  end

  private

  def update_params
  	params.permit(:sender, :text)
  end
end
