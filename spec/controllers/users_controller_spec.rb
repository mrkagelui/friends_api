require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  context "when doing POST create" do
  	it "should return http success upon valid email" do
  	  post :create, { params: { email: "alice@bob.com" }, format: :json }
  	  expect(response).to have_http_status :created
  	end

  	it "should return bad request upon invalid email" do
  	  post :create, { params: { email: "alice@bob" }, format: :json }
  	  expect(response).to have_http_status :bad_request
  	end
  end

  context "when doing GET get_friends" do
    it "should return all friends" do
      test_user = User.create email: "alice@brian.com"
      test_user1 = User.create email: "alic@bob.com"
      test_user2 = User.create email: "alice@bo.com"
      test_user3 = User.create email: "alice@bb.com"
      Friendship.create user_where_it_is_user1: test_user, user_where_it_is_user2: test_user1
      Friendship.create user_where_it_is_user1: test_user2, user_where_it_is_user2: test_user
      Friendship.create user_where_it_is_user1: test_user3, user_where_it_is_user2: test_user

      get :get_friends, { params: { email: "alice@brian.com" }, format: :json }
      expect(response).to have_http_status :ok
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['success']).to be true
      expect(parsed_body['count']).to be 3
      expect(parsed_body['friends'].length).to be 3
      expect(parsed_body['friends']).to include "alic@bob.com"
    end
  end
end
