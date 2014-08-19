Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  controller :pages, action: :show do
    root page: 'home'
    %w(composer_nights music_tech contact).each do |page|
      path = page.gsub('_', '')
      name = page.gsub('/', '_')
      get path, as: name, page: name
    end
  end

  scope path: 'composernights' do
    resource :signup do
      post :send_edit_link, on: :collection, as: :edit_link_for
    end
  end
  
end
