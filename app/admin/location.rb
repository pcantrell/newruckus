ActiveAdmin.register Location do
  actions :all, except: [:show]

  permit_params Location.attribute_names - %w(created_at updated_at)
end
