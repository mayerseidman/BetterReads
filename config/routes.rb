Omniauthpls::Application.routes.draw do
<<<<<<< HEAD
=======

>>>>>>> 5f1c226cff2d311921614de9f65965067e080779
 
  resources :users
 
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#create"
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'groups', to: 'groups#index', as: 'listgroups'
  get 'group/:id' , to: 'groups#show', as: 'group'


end
