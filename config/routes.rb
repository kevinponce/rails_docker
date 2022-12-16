Rails.application.routes.draw do
  resources :dynamo, only: [:index]
  resources :redis, only: [:index]
  resources :s3, only: [:index]

  root to: 'home#index'
end
