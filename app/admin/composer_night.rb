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
      ul do
        composer_night.signups.includes(:presenter).each do |signup|
          render 'admin/signup_list_item', signup: signup, show_info: true
        end
      end
    end

    div class: 'attributes_table' do
      composer_night.signups.includes(:presenter).each do |signup|
        panel "#{signup.presenter.first_name}’s info" do
          render 'shared/signup_info_summary', signup: signup
        end
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

  controller do
    include Admin::CustomRedirectOnSave
  end
end
