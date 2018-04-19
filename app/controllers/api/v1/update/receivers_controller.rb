class Api::V1::Update::ReceiversController < ApplicationController
  def retrieve
    sender = User.find_by! email: update_params[:sender]
    friends = sender.friends
    followers = sender.followers
    mentioned_emails = update_params[:text].scan(
    	/\b([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6})\b/).flatten
    mentioneds = mentioned_emails.map { |e| User.find_by(email: e) } .compact
    blockers = sender.blockers
    receivers = (friends | followers | mentioneds) - blockers
    receiver_emails = receivers.map { |e| e.email }
    render json: { success: true, recipients: receiver_emails }, status: :ok
  end

  private

  def update_params
  	params.permit(:sender, :text)
  end
end
