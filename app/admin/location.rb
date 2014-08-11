ActiveAdmin.register Location do
  permit_params Location.attribute_names - %w(id created_at updated_at)
end
