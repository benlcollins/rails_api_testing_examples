require 'rails_helper'

describe Muppet, :type => :model do
	
	let(:no_name){Muppet.new(name: "", image_url: "muppet.jpg")}
	let(:no_image){Muppet.new(name: "muppet", image_url: "")}
	let(:muppet){Muppet.new(name: "muppet", image_url: "muppet.jpg")}

	it "doesn't save a muppet without a name" do
		expect(no_name).not_to be_valid, "Muppet saved without a name"
	end

	it "doesn't save without a valid image_url" do
		expect(no_image).not_to be_valid, "Muppet saved without a valid image_url"
	end

	it "saves with valid name and image_url" do
		expect(muppet).to be_valid, "Muppet saved without a valid name and image_url"
	end
end