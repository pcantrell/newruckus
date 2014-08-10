ActiveAdmin.register ComposerNight do
  actions :all, except: [:show]

  permit_params ComposerNight.attribute_names - %w(created_at updated_at name_for_searching)

  index do
    selectable_column
    id_column
    column :location
    column :start_time
    column :slots
    actions
  end
end
