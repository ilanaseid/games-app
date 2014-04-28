GamesApp::Application.routes.draw do



	root :to => "welcome#index"

	get '/login', to: 'sessions#new'
	post '/sessions', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy'

	resources :messages
	resources :users
	resources :challenges

	post '/faye', to: 'challenges#event'


end
