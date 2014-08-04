class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.text :name
      t.text :email
      t.text :comments
      t.text :phone
      t.boolean :guidelines

      t.timestamps
    end
  end
end
