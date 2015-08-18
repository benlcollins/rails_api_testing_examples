require 'pry'
require 'test_helper'
 
class ApiControllerTest < ActionController::TestCase

	# setup
	setup do
		@one = muppets(:one)
	end

	test "should get success response after get request" do
		get :index, :format => :json
		assert_response :success
	end

	test "get 'show' test" do
		get :show, :id => @one["id"]
		assert_response :success
		body = JSON.parse(response.body)
		assert_equal "kermit", body["name"].downcase
	end


	# test post action with valid muppet
	test "adds a valid new muppet with post action" do
    post :create, { name: "New_muppet", image_url: "New_muppet" }	
    assert_response :success
    assert_equal "New_muppet", Muppet.last.name
  end

  # test post action with invalid muppet
	test "does not add a new muppet with invalid parameters" do
    post :create, { name: nil, image_url: "New_muppet" }	
    assert_response 418 # tests for status code 418 because we specifically setup our app this way
  end

end