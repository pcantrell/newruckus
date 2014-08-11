ActiveAdmin.register Person do
  permit_params Person.attribute_names - %w(id created_at updated_at)

  index do
    selectable_column
    id_column
    column :name
    column :url
    column :address
    actions
  end

  filter :name
  filter :url
  filter :address

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :url
      f.input :bio
    end
    f.actions
  end

end
