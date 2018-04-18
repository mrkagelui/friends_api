require 'rails_helper'

RSpec.describe Api::V1::Update::ReceiversController, type: :controller do
  before(:each) do
  	# user <-(friend)-> user3, user1 -(follow)-> user3, user2 -(block)-> user3
  	# user1 <-(friend)-> user2, user1 -(block)-> user2
    @users = create_list(:user, 5)
    Friendship.create user_where_it_is_user1: @users[0], user_where_it_is_user2: @users[3]
    Friendship.create user_where_it_is_user1: @users[1], user_where_it_is_user2: @users[2]
    Following.create user_where_it_is_source: @users[3], user_where_it_is_audience: @users[1]
    Blockade.create user_where_it_is_blocker: @users[2], user_where_it_is_blockee: @users[3]
    Blockade.create user_where_it_is_blocker: @users[1], user_where_it_is_blockee: @users[2]
  end

  context "when retrieving recipients of an update" do
  	it "should return not_found when sender does not exist" do
      post :retrieve, { params: 
	  							{ 
	  							  sender: "bruce_wayne@test.com",
	  							  text: "hello #{@users[0].email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :not_found
	end

	it "should not return users in block even if he is a friend" do
	  post :retrieve, { params: 
	  							{ 
	  							  sender: @users[2].email,
	  							  text: "hello #{@users[0].email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :ok
	  parsed_body = JSON.parse(response.body)
	  expect(parsed_body['success']).to be true
	  expect(parsed_body['recipients']).not_to include @users[1].email
	end

	it "should return friend even if not mentioned" do
	  post :retrieve, { params: 
	  							{ 
	  							  sender: @users[1].email,
	  							  text: "hello #{@users[0].email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :ok
	  parsed_body = JSON.parse(response.body)
	  expect(parsed_body['success']).to be true
	  expect(parsed_body['recipients']).to include @users[2].email
	end

    it "should return friend, follower and strangers mentioned" do
      post :retrieve, { params: 
	  							{ 
	  							  sender: @users[3].email,
	  							  text: "hello #{@users[0].email} #{@users[4].email}" 
	  							},
	  						format: :json
	  					   }
	  expect(response).to have_http_status :ok
	  parsed_body = JSON.parse(response.body)
	  expect(parsed_body['success']).to be true
	  expect(parsed_body['recipients']).to include @users[0].email
	  expect(parsed_body['recipients']).to include @users[1].email
	  expect(parsed_body['recipients']).to include @users[4].email
	end
  end
end
