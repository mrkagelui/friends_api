require 'rails_helper'

RSpec.describe Api::V1::FriendshipsController, type: :controller do
  before(:each) do
  	@user1 = User.create email: "alice@bob.com"
  	@user2 = User.create email: "bob@alice.com"
  end

  context "when doing POST create" do
    it "return success when both users exist" do
      post :create, { params: { friends: ["alice@bob.com", "bob@alice.com"] }, format: :json }
      expect(response).to have_http_status :created
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to have_key 'success'
      expect(parsed_body['success']).to be true
    end

    it "return not found when one user does not exist" do
      post :create, { params: { friends: ["alice@bob.com", "bob@cali.com"] }, format: :json }
      expect(response).to have_http_status :not_found
    end
  end
end
