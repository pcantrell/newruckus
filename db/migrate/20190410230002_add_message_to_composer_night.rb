class AddMessageToComposerNight < ActiveRecord::Migration
  def change
    add_column :composer_nights, :message, :text
  end
end
