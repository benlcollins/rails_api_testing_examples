require 'pry'
require 'test_helper'
 
class ApiControllerTest < ActionController::TestCase
	
	# setup
	setup do
		@one = muppets(:one)
	end

	test "should get success response after get request" do
		get :index
		assert_response :success		
		# assert_not_nil assigns(:muppets)
	end

	test "it should return JSON" do 
		get :index, :format => :json
	end

	test "get 'show' test" do
		get :show, :id => @one["id"]
		assert_response :success
		body = JSON.parse(response.body)
		assert_equal "kermit", body['name']
	end

	# test post action
	test "should add a new muppet with post action" do
    assert_difference('Muppet.count') do
      post :create, muppet: { name: "New Muppet", image_url: "New Muppet picture" }
      # Muppet.create(name: "New Muppet", image_url: "New Muppet picture")
    end
  end

end