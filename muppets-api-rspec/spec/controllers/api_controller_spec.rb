require 'rails_helper'
require 'pry'

describe ApiController, :type => :controller do
	
	# index test
	describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns all the muppets as JSON" do
    	FactoryGirl.create :muppet, name: "gonzo", image_url: "gonzo.jpg"
    	FactoryGirl.create :muppet, name: "kermit", image_url: "kermit.jpg"

    	get :index, {}, { "Accept" => "application/json" }

    	body = JSON.parse(response.body)
    	muppet_names = body.map { |m| m['name'] }
      # muppet_names = body.map(&:name)

    	expect(muppet_names).to match_array(["gonzo","kermit"])
    end
  end

  # show test
  describe "GET #show" do

  end

  # create test
  describe "POST #create" do

  end

  # update test
  describe "PUT #update" do

  end

  # destroy test
  describe "DELETE #destroy" do

  end


end