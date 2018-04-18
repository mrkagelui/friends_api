require 'rails_helper'

RSpec.describe Api::V1::BlockadesController, type: :controller do
  before(:each) do
    @test_user = create(:user)
    @test_user1 = create(:user)
  end

  context "when doing POST create" do
  	it "should return not_found when email not found" do
  	  post :create, { params: { requestor: @test_user.email, target: "barry_allen@test.com" }, format: :json }
  	  expect(response).to have_http_status :not_found
  	end

  	it "should return ok under normal circumstances" do
  	  post :create, { params: { requestor: @test_user.email, target: @test_user1.email }, format: :json }
  	  expect(response).to have_http_status :ok
  	  parsed_body = JSON.parse(response.body)
  	  expect(parsed_body['success']).to be true
  	end
  end
end
