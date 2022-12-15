Rails.application.routes.draw do
  resources :s3, only: [:index]

  root to: 'home#index'
end
