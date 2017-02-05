Rails.application.routes.draw do
  post '/callback' => 'responses#callback'
  root 'responses#index'
end
