require 'test_helper'

class MuppetTest < ActiveSupport::TestCase

	test "muppet should not save without a name" do
		muppet = Muppet.new(name: "", image_url: "whatever.com/")
		assert_not muppet.save, "Saved muppet without a name"
	end

	test "muppet should not save without an image_url" do
		muppet = Muppet.new(name: "whatever", image_url: "")
		assert_not muppet.save, "Saved muppet without an image url"
	end

	test "muppet should save with valid parameters" do
		muppet = Muppet.new(name: "Muppet Name", image_url: "muppet_images.com/")
		assert muppet.valid?, "Muppet not valid without all parameters"
		assert_equal "Muppet Name", muppet.name, "The name of the muppets does not match!"
	end

	# test "test not ready" do
	# 	flunk("Test not ready yet. Still writing assertions.")
	# end
end
