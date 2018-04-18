require 'rails_helper'

describe Constraint::Api_constraints do
  let(:api_constraints_v1) { Constraint::Api_constraints.new(version: 1) }
  let(:api_constraints_v2) { Constraint::Api_constraints.new(version: 2, default: true) }

  context "matches?" do
  	it "should match when version provided in header" do
  	  request = double(host: 'api.friends.dev', 
  	  	headers: {'Accept' => "application/vnd.friends.v1"})
  	  expect(api_constraints_v1.matches?(request)).to be true
  	  expect(api_constraints_v2.matches?(request)).to be_falsy
  	end

  	it "should match default when no version provided in header" do
  		request = double(host: 'api.friends.dev', headers: {})
  		expect(api_constraints_v1.matches?(request)).to be_falsy
  		expect(api_constraints_v2.matches?(request)).to be true
  	end
  end
end