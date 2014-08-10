class DropSignups < ActiveRecord::Migration
  def up
    drop_table :signups
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
