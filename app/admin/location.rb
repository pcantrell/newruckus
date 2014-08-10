ActiveAdmin.register Location do
  permit_params Location.attribute_names - %w(created_at updated_at)

  form do |f|
    f.inputs "Admin Details" do
      f.input :name, as: :string
      f.input :url, as: :string
      f.input :address, as: :string
      f.input :map_image_path, as: :string
    end
    f.actions
  end

end
