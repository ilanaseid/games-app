GamesApp::Application.routes.draw do

  root :to => "welcome#index"

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"

  resources :users

  resources :challenges
  
end
