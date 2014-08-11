ActiveAdmin.register ComposerNightSignup do
  editable_attrs = ComposerNightSignup.attribute_names - %w(id created_at updated_at)
  permit_params editable_attrs

  menu label: 'Signups'

  index do
    selectable_column
    id_column
    column :presenter
    column :composer_night
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :presenter, as: :select, collection: Person.order(:name), hint: if f.object.presenter
        link_to "Edit #{f.object.presenter.name}", edit_admin_person_path(f.object.presenter)
      end
      f.input :composer_night, as: :select, collection: ComposerNight.order('start_time desc'), hint: if f.object.composer_night
        link_to "Edit #{f.object.composer_night.title}", edit_admin_composer_night_path(1)
      end
      editable_attrs.each do |attr|
        f.input attr unless attr =~ /_id$/
      end
    end
    f.actions
  end
end
