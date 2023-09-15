Rails.application.routes.draw do
  root to: redirect(Avo.configuration.root_path)
  devise_for :users
  
  authenticate :user, ->(user) { user.is_admin? || user.is_manager? } do
    mount Avo::Engine, at: Avo.configuration.root_path

    scope :admin do
      get "settings", to: "avo/tools#settings"
    end
  end
end
