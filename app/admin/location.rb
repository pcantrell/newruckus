ActiveAdmin.register Location do
  permit_params Location.attribute_names - %w(created_at updated_at)
end
