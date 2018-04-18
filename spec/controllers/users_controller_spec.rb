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
end
