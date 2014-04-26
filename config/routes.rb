GamesApp::Application.routes.draw do

	root to: 'welcome#index' 
	resources :messages
  resources :users
  resources :challenges
  post '/faye', to: 'challenges#event'
  
end
