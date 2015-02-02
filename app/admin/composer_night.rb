ActiveAdmin.register ComposerNight do
  permit_params ComposerNight.attribute_names - %w(created_at updated_at name_for_searching)

  config.sort_order = "start_time_desc"
  index do
    selectable_column
    id_column
    column :location
    column :start_time
    column :slots
    column 'Slots filled' do |cn|
      cn.signups.count
    end
    actions
  end

  show do
    default_main_content

    panel 'Signed up' do
      render 'signup_summary', composer_night: composer_night
    end

    div class: 'attributes_table' do
      panel "Presenter info" do
        render 'info_summary', composer_night: composer_night
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :location
      f.input :start_time, as: :datetime
      f.input :slots
    end
    f.actions
  end

  member_action :email_info_summary, method: :post do
    AdminNotifications.delay.info_summary(resource, params[:comments])
    flash[:notice] = "Info summary sent"
    redirect_to admin_composer_night_path(resource)
  end

  controller do
    include Admin::CustomRedirectOnSave
  end
end
