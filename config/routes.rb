Rails.application.routes.draw do
  devise_for :users
  resources :users do
    collection do
      get :registration_edit
      put :update
      delete :delete
      get :senha
      put :update_password
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
