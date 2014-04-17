Rails.application.routes.draw do
  get '/app_logout' => 'sessions#app_logout'
  get '/cas_logout' => 'sessions#cas_logout'
end