ActiveAdmin.register Delayed::Job do
  menu label: 'Jobs'

  index do
    selectable_column
    id_column
    column :attempts
    column :run_at
    column :locked_at
    actions
  end
end
