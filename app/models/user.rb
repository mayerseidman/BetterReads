class User < ActiveRecord::Base

# client = Goodreads::Client.new(:api_key => 'UpIly3BURwhZ52tmj4ag', :api_secret => 'vIlBCRroZ5Esfn4RRQxY7Sd8sfOx7wOvtWY6thJfqQ')




# # def self.review = client.review('id')

# # end


# def self.from_omniauth(auth, code)
#   where(auth.slice(:provider, :uid)).first_or_create do |user|
#     user.provider = auth.provider
#     user.uid = auth.uid
#     user.name = auth.info.name
#     user.email = auth.info.email
#     user.auth_code = code
#     user.picture = auth.info.image
#     user.refresh_token = auth.credentials.refresh_token
#   end
# end

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


  def goodreads
    @goodreads ||= Goodreads::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
  end
end  

