require 'rails_helper'

RSpec.describe Api::V1::FriendshipsController, type: :controller do
  before(:each) do
    @test_users = create_list(:user, 4)
    Friendship.create user_where_it_is_user1: @test_users[0], user_where_it_is_user2: @test_users[3]
    Friendship.create user_where_it_is_user1: @test_users[1], user_where_it_is_user2: @test_users[3]
    Friendship.create user_where_it_is_user1: @test_users[2], user_where_it_is_user2: @test_users[3]
  end

  context "when doing POST create" do
    it "return success when both users exist" do
      post :create, { params: { friends: [@test_users[1].email, @test_users[2].email] }, format: :json }
      expect(response).to have_http_status :created
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to have_key 'success'
      expect(parsed_body['success']).to be true
    end

    it "return not found when one user does not exist" do
      # all fake users have email like "xxx@example.com"
      post :create, { params: { friends: [@test_users[1].email, "bob@cali.com"] }, format: :json }
      expect(response).to have_http_status :not_found
    end
  end

  context "when doing GET get_friends" do
    it "should return all friends" do
      get :get_friends, { params: { email: @test_users[3].email }, format: :json }
      expect(response).to have_http_status :ok
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['success']).to be true
      expect(parsed_body['count']).to be 3
      expect(parsed_body['friends'].length).to be 3
      expect(parsed_body['friends']).to include @test_users[2].email
    end
  end

  context "when doing GET get_mutual_friends" do
    it "should return nothing when there is no mutual friends" do
      post :get_common_friends, { params: { friends: [@test_users[0].email, @test_users[3].email] }, format: :json }
      expect(response).to have_http_status :ok
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['success']).to be true
      expect(parsed_body['count']).to be 0
    end

    it "should return all mutual friends when there is any" do
      Friendship.create user_where_it_is_user1: @test_users[1], user_where_it_is_user2: @test_users[2]
      post :get_common_friends, { params: { friends: [@test_users[3].email, @test_users[1].email] }, format: :json }
      expect(response).to have_http_status :ok
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['success']).to be true
      expect(parsed_body['count']).to be 1
      expect(parsed_body['friends']).to include @test_users[2].email
    end
  end
end
