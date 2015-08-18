class Muppet < ActiveRecord::Base
  validates :name, presence: true
  validates :image_url, presence: true

  def shouting_muppet
  	return name.upcase
  end
end