Rails.application.routes.draw do
  root to: redirect(Avo.configuration.root_path)
  devise_for :users
  
  authenticate :user, ->(user) { user.is_admin? || user.is_manager? } do
    mount Avo::Engine, at: Avo.configuration.root_path

    scope :admin do
      get "settings", to: "avo/tools#settings"
      post "settings", to: "avo/tools#update_settings"
    end
  end
end

if defined? Avo
  Avo::Engine.routes.draw do
    post "new_comment_from_tool/:ticket_id", to: "comments#new_from_tool", as: :new_comment_from_tool
  end
end
