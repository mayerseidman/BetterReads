Omniauthpls::Application.routes.draw do
 
  resources :users
 
  # get 'https://betterreads.herokuapp.com/auth/goodreads/callback', :to => 'sessions#create'
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#create"
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'groups', to: 'groups#index', as: 'listgroups'
  get 'group/:id' , to: 'groups#show', as: 'group'
  get 'group/send_alert/:group_id', to: 'groups#send_alert', as: 'group_send_alert'


end
