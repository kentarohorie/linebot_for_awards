Rails.application.routes.draw do
  post '/callback' => 'responses#callback'
end
