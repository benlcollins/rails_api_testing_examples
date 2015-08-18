require 'test_helper'
require 'pry'

class MuppetTest < ActiveSupport::TestCase

	setup do
		@muppet = Muppet.new(name: "Kermit", image_url: "kermit.jpg")
	end

	test "muppet does not save without a name" do
		@muppet.name = nil
		assert_not @muppet.save, "Test fails because app saves muppet without a name"
	end

	test "muppet should not save without an image_url" do
		@muppet.image_url = nil
		assert_not @muppet.save, "Saved muppet without an image url"
	end

	test "valid muppet does save" do
		assert @muppet.save 
	end

	test "shouting muppet is uppercase" do
		assert_equal "KERMIT", @muppet.shouting_muppet, "Muppet not in uppercase"
	end

	# test "test not finished" do
	# 	flunk("I haven't finished writing these tests yet")
	# end

end
