ActiveAdmin.register Person do
  permit_params Person.attribute_names - %w(created_at updated_at)

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
    f.inputs "Admin Details" do
      f.input :name, as: :string
      f.input :email, as: :string
      f.input :url, as: :string
      f.input :bio
    end
    f.actions
  end

end
