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

  scope 'composernights/signup', controller: :signups do
    get   '/', action: :new, as: :signup
    post  '/', action: :create
    post  :send_edit_link, as: :signup_edit_link
    get   '/:token', action: :edit, as: :edit_signup
    patch '/:token', action: :update
  end

end
