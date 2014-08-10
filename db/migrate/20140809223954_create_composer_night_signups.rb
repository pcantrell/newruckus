class CreateComposerNightSignups < ActiveRecord::Migration
  def change
    create_table :composer_night_signups do |t|
      t.references :person
      t.references :composer_night
      t.text :comments
      t.text :title
      t.text :performers
      t.text :approx_length
      t.text :description
      t.text :special_needs

      t.timestamps

      t.index :person_id
      t.index :composer_night_id
      t.index :created_at
    end
  end
end


