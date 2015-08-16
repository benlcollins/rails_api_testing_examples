class CreateMuppets < ActiveRecord::Migration
  def change
    create_table :muppets do |t|
      t.string :name
      t.string :image_url
    end
  end
end
