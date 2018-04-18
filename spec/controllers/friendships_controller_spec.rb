require 'rails_helper'

RSpec.describe Api::V1::FriendshipsController, type: :controller do
  before(:each) do
    @test_user = create(:user)
    @test_user1 = create(:user)
    @test_user2 = create(:user)
    @test_user3 = create(:user)
    Friendship.create user_where_it_is_user1: @test_user, user_where_it_is_user2: @test_user1
    Friendship.create user_where_it_is_user1: @test_user2, user_where_it_is_user2: @test_user
    Friendship.create user_where_it_is_user1: @test_user3, user_where_it_is_user2: @test_user
  end

  context "when doing POST create" do
    it "return success when both users exist" do
      post :create, { params: { friends: [@test_user1.email, @test_user2.email] }, format: :json }
      expect(response).to have_http_status :created
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to have_key 'success'
      expect(parsed_body['success']).to be true
    end

    it "return not found when one user does not exist" do
      # all fake users have email like "xxx@example.com"
      post :create, { params: { friends: [@test_user1.email, "bob@cali.com"] }, format: :json }
      expect(response).to have_http_status :not_found
    end
  end

  context "when doing GET get_friends" do
    it "should return all friends" do

      get :get_friends, { params: { email: @test_user.email }, format: :json }
      expect(response).to have_http_status :ok
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['success']).to be true
      expect(parsed_body['count']).to be 3
      expect(parsed_body['friends'].length).to be 3
      expect(parsed_body['friends']).to include @test_user2.email
    end
  end
end
