class AddComposerNightVisible < ActiveRecord::Migration
  def change
    add_column :composer_nights, :visible, :boolean, default: true
  end
end
