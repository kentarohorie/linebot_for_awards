Rails.application.routes.draw do
  binding.pry
  root 'responses#index'
  resources :responses, only: :index
end
