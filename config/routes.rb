Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update] do
    collection do
      post :facebook_auth, to: 'facebook#auth'
    end
  end
end
