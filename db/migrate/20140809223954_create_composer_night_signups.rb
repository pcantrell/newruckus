class CreateComposerNightSignups < ActiveRecord::Migration
  def change
    create_table :composer_night_signups do |t|
      t.boolean :active, default: true
      t.references :presenter
      t.references :composer_night
      t.text :comments
      t.text :internal_notes
      t.text :title
      t.text :performers
      t.text :approx_length
      t.text :description
      t.text :special_needs

      t.timestamps

      t.index :presenter_id
      t.index :composer_night_id
      t.index :created_at
    end
  end
end


