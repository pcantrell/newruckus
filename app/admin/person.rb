ActiveAdmin.register Person do
  permit_params Person.attribute_names - %w(id created_at updated_at)

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :bio do |person|
      truncate(person.bio, omision: "...", length: 50)
    end
    actions
  end

  filter :name
  filter :email

  form do |f|
    f.inputs do
      f.input :name
      f.input :first_name, placeholder: f.object.default_first_name
      f.input :email
      f.input :phone
      f.input :url
      f.input :bio
    end
    f.actions
  end

  controller do
    include Admin::CustomRedirectOnSave
  end
end
