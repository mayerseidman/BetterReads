class User < ActiveRecord::Base

    def self.create_with_omniauth(auth)
      user = where(auth.slice("provider", "uid")).first_or_create do |user|
        user.provider = auth["provider"]
        user.id = auth["uid"]
        user.name = auth["info"]["name"]
        user.username = auth["info"]["username"]
        user.oauth_token = auth["credentials"]["token"]
        user.oauth_secret = auth["credentials"]["secret"]
        user.save!
        user
    end  
    end
end  

