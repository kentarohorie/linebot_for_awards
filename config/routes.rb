Rails.application.routes.draw do
  root 'responses#index'
  resources :responses, only: :index
end
