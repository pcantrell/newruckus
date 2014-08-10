ActiveAdmin.register ComposerNight do
  permit_params ComposerNight.attribute_names - %w(created_at updated_at name_for_searching)

  form do |f|
    f.inputs "Admin Details" do
      f.input :start_time
      f.input :location
      f.input :slots
    end
    f.actions
  end

end
