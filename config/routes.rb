Rails.application.routes.draw do
  resources :doctors, module: :doctor, only: [:show] do
    resources :patients, only: [:destroy]
  end
end
