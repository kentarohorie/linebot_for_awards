Rails.application.routes.draw do
  puts "=~=~=~=~=~=~=~=~=~=~=~=~"
  puts params
  puts "=~=~=~=~=~=~=~=~=~=~=~=~"
  root 'responses#index'
  resources :responses, only: :index
end
