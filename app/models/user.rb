class User < ActiveRecord::Base

def self.create_with_omniauth(auth)
  user = where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  # create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"]
    user.username = auth["info"]["username"]
    user.oauth_token = auth["credentials"]["token"]
    user.oauth_secret = auth["credentials"]["secret"]
    user.save!
    user
  
end

def client
    consumer = OAuth::Consumer.new(GOODREADS_API_KEY,
                                   GOODREADS_API_SECRET,
                                   :site => 'http://www.goodreads.com')
    access_token = OAuth::AccessToken.new(consumer, oauth_access_token, oauth_access_secret)
    Goodreads::Client.new(oauth_token: access_token, api_key: GOODREADS_API_KEY, api_secret: GOODREADS_API_SECRET)
end

end  

