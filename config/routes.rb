Rails.application.routes.draw do
  post '/auth/login',   to: 'authentication#login'
  get '/chains/total',  to: 'chains#total'
  post '/auth/logout',  to: 'authentication#logout'
  
  resources :users, param: :_username
  resources :chains, param: :_name   

  resources :visitors, param: :_name do
  	member do 
  		post :register_incidence, to:'visitors#register_incidence'
  	end
  end

  default_url_options :host => "localhost:3000"
  get '/*a', to: 'application#not_found'


end