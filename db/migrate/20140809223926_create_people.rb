class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.text :name
      t.text :name_for_searching
      t.text :email
      t.text :url
      t.text :bio

      t.timestamps

      t.index :name_for_searching
      t.index :email
    end
  end
end
