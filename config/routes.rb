Omniauthpls::Application.routes.draw do

 
  get "groups/index"
  get "groups/show"
  resources :users
 
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#show"
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'groups', to: 'groups#index', as: 'listgroups'
  get 'group' , to: 'groups#show', as: 'group'

end