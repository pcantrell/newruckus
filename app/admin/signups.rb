ActiveAdmin.register Signup do
  editable_attrs = Signup.attribute_names - %w(id created_at updated_at)
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

      assign_event_id = params[:assign_composer_night_id]
      old_event = nil
      if assign_event_id
        old_event = f.object.composer_night
        f.object.composer_night = ComposerNight.find(assign_event_id)
      end
      f.input :composer_night, as: :select, collection: ComposerNight.order('start_time desc'), hint: if assign_event_id
        "<span style='font-weight:bold;color:#800'>← Change Composer Night? (was #{old_event.title || 'unset'})</span>".html_safe
      elsif f.object.composer_night
        link_to "Edit #{f.object.composer_night.title}", edit_admin_composer_night_path(1)
      end

      editable_attrs.each do |attr|
        f.input attr unless attr =~ /_id$/
      end
    end
    f.actions
  end

  controller do
    include Admin::CustomRedirectOnSave

    def save_redirect_url
      admin_dashboard_url
    end
  end
end
