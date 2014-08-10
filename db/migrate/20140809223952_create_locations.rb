class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text :name
      t.text :url
      t.text :address
      t.string :map_image_path

      t.timestamps
    end
  end
end
