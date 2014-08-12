class RenameComposerNightSignupToSignup < ActiveRecord::Migration
  def change
    rename_table :composer_night_signups, :signups
  end
end
