ActiveAdmin.register ComposerNightSignup do
  actions :all, except: [:show]

  permit_params ComposerNightSignup.attribute_names - %w(created_at updated_at)

  menu label: 'Signups'

  index do
    selectable_column
    id_column
    column :presenter
    column :composer_night
    column :created_at
    actions
  end
end
