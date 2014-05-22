Omniauthpls::Application.routes.draw do
 
  resources :users
 
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#create"
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'groups', to: 'group#index', as: 'groups'
  get 'group' , to: 'group#show', as: 'group'

end
