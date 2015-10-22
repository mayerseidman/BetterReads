Omniauthpls::Application.routes.draw do
 
  resources :users
  resources :groups, only: ['index', 'show'] 

  # get 'https://betterreads.herokuapp.com/auth/goodreads/callback', :to => 'sessions#create'
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#create"
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'group/send_alert/:group_id', to: 'groups#send_alert', as: 'group_send_alert'
end
