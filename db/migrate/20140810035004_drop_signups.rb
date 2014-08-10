class DropSignups < ActiveRecord::Migration
  def change
    drop_table :signups
  end
end
