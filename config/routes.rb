Rails.application.routes.draw do
  resources :hospitals, only: [:show]
  resources :patients, only: [:index]
  resources :doctors, module: :doctor, only: [:show] do
    resources :patients, only: [:destroy]  
  end
end
