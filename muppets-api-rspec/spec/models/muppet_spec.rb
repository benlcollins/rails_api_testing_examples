require 'rails_helper'

RSpec.describe Muppet, :type => :model do
	it "doesn't save without a valid name" do
		muppet = Muppet.new(name: "", image_url: "muppet.jpg")
		expect(muppet).not_to be_valid, "Muppet saved without a valid name"
	end

	it "doesn't save without a valid image_url" do
		muppet = Muppet.new(name: "muppet", image_url: "")
		expect(muppet).not_to be_valid, "Muppet saved without a valid image_url"
	end

	it "saves with valid name and image_url" do
		muppet = Muppet.new(name: "muppet", image_url: "muppet.jpg")
		expect(muppet).to be_valid, "Muppet saved without a valid name and image_url"
	end
end