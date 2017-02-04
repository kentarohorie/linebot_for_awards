Rails.application.routes.draw do
  root 'responses#index'
  post '/callback' => 'responses#callback'
  resources :responses, only: :index
end
