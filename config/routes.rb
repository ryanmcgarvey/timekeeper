Rails.application.routes.draw do
  devise_for :users
  root 'clients#index'
  resources :client_profiles
  resources :clients do
    resources :timelogs
    resources :client_profiles
  end

end
