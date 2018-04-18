require 'rails_helper'

RSpec.describe Api::V1::Update::ReceiversController, type: :controller do
  before(:each) do
  	# user <-(friend)-> user3, user1 -(follow)-> user3, user2 -(block)-> user3
  	# user1 <-(friend)-> user2, user1 -(block)-> user2
    @user = create(:user)
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    Friendship.create user_where_it_is_user1: @user, user_where_it_is_user2: @user3
    Friendship.create user_where_it_is_user1: @user1, user_where_it_is_user2: @user2
    Following.create user_where_it_is_source: @user3, user_where_it_is_audience: @user1
    Blockade.create user_where_it_is_blocker: @user2, user_where_it_is_blockee: @user3
    Blockade.create user_where_it_is_blocker: @user1, user_where_it_is_blockee: @user2
  end

  context "when retrieving recipients of an update" do
  	it "should return not_found when sender does not exist" do
      post :retrieve, { params: 
	  							{ 
	  							  sender: "bruce_wayne@test.com",
	  							  text: "hello #{@user.email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :not_found
	end

	it "should not return users in block even if he is a friend" do
	  post :retrieve, { params: 
	  							{ 
	  							  sender: @user2.email,
	  							  text: "hello #{@user.email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :ok
	  parsed_body = JSON.parse(response.body)
	  expect(parsed_body['success']).to be true
	  expect(parsed_body['recipients']).not_to include @user1.email
	end

	it "should return friend even if not mentioned" do
	  post :retrieve, { params: 
	  							{ 
	  							  sender: @user1.email,
	  							  text: "hello #{@user.email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :ok
	  parsed_body = JSON.parse(response.body)
	  expect(parsed_body['success']).to be true
	  expect(parsed_body['recipients']).to include @user2.email
	end

    it "should return friend, follower and strangers mentioned" do
      post :retrieve, { params: 
	  							{ 
	  							  sender: @user3.email,
	  							  text: "hello #{@user.email} #{@user4.email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :ok
	  parsed_body = JSON.parse(response.body)
	  expect(parsed_body['success']).to be true
	  expect(parsed_body['recipients']).to include @user.email
	  expect(parsed_body['recipients']).to include @user1.email
	  expect(parsed_body['recipients']).to include @user4.email
	end
  end
end
