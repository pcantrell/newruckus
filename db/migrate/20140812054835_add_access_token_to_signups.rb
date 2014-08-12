class AddAccessTokenToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :access_token, :text
    add_index :signups, :access_token, unique: true
  end
end
