Omniauthpls::Application.routes.draw do
  get "group/index"
  get "group/show"
  resources :users
 
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#show"
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'group', to: 'users#index', as: 'group'

end
