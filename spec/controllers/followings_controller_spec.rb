require 'rails_helper'

RSpec.describe Api::V1::FollowingsController, type: :controller do
  before(:each) do
    @test_users = create_list(:user, 2)
  end

  context "when doing POST follow" do
  	it "should return not_found when email not found" do
  	  post :create, { params: { requestor: @test_users[0].email, target: "barry_allen@test.com" }, format: :json }
  	  expect(response).to have_http_status :not_found
  	end

  	it "should return success under normal circumstances" do
  	  post :create, { params: { requestor: @test_users[0].email, target: @test_users[1].email }, format: :json }
  	  expect(response).to have_http_status :ok
  	  parsed_body = JSON.parse(response.body)
  	  expect(parsed_body['success']).to be true
  	end
  end
end
