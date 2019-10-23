Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:index, :show] do
    collection do
      post :facebook_auth, to: 'facebook#auth'
    end
  end
end
