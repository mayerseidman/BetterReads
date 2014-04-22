Omniauthpls::Application.routes.draw do
 get '/auth/:goodreads/callback', :to => 'sessions#create'

end
