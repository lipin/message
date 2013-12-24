Demo::Application.routes.draw do
  devise_for :users

  resources :conversations do
    resources :messages
  end
  root 'home#index'
end
