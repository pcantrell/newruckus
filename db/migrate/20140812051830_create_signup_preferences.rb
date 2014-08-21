class CreateSignupPreferences < ActiveRecord::Migration
  def change
    create_table :signup_preferences do |t|
      t.references :signup, null: false, index: true
      t.references :composer_night, null: false, index: true
      t.string :status, null: false

      t.timestamps
    end

    add_index :signup_preferences, [:signup_id, :composer_night_id], unique: true
    add_index :signup_preferences, [:composer_night_id, :signup_id], unique: true
  end
end
