GamesApp::Application.routes.draw do



	root :to => "welcome#index"

	get '/login', to: 'sessions#new'
	post '/sessions', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy'

	resources :messages
	resources :users
	get '/challenges/index_for_user', to: 'challenges#index_for_user'
	resources :challenges

	get '/leaderboard', to: 'users#leaderboard'

end
