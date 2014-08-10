class CreateComposerNights < ActiveRecord::Migration
  def change
    create_table :composer_nights do |t|
      t.timestamp :start_time
      t.references :location
      t.integer :slots

      t.timestamps

      t.index :start_time
    end
  end
end
