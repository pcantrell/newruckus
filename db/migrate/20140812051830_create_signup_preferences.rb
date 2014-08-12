class CreateSignupPreferences < ActiveRecord::Migration
  def change
    create_table :signup_preferences do |t|
      t.references :signup, null: false, index: true
      t.references :composer_night,        null: false, index: true
      t.string :status, null: false

      t.timestamps
    end
  end
end
