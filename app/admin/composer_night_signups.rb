ActiveAdmin.register ComposerNightSignup do
  permit_params ComposerNightSignup.attribute_names - %w(created_at updated_at)

  index do
    selectable_column
    id_column
    column :person
    column :composer_night
    actions
  end
end
