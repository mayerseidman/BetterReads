class User < ActiveRecord::Base
     require 'rubygems'
      require 'nokogiri'
      require 'open-uri'



    has_and_belongs_to_many :groups

    def self.create_with_omniauth(auth)
      user = where(auth.slice("provider", "uid")).first_or_create do |user|
        user.provider = auth["provider"]
        user.id = auth["uid"]
        user.name = auth["info"]["name"]
        user.username = auth["info"]["username"]
        user.oauth_token = auth["credentials"]["token"]
        user.oauth_secret = auth["credentials"]["secret"]
        user.location = (Geocoder.coordinates auth["info"]["location"]).to_s
        user.auth = auth
        user.save!
        end  
    end

    def alert
        user = User.last
        user

        client = Goodreads::Client.new(oauth_token: user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
        @group_list = client.group_list(user.id, 'sort')

        unless @group_list.group.nil?
          @group_list.group.each do |g| 
            url = "https://www.goodreads.com/group/#{g.id}/members?format=xml&key='UpIly3BURwhZ52tmj4ag'"
            doc = Nokogiri::HTML(open(url))
            group = doc.xpath("//id").map{ |tr| tr.xpath("//id").map(&:text) }[0]
          
            group_record = Group.where(id: g.id).first_or_create(title: g.title)

                group.each do |id|
                  begin
                    url = "https://www.goodreads.com/user/show/#{id}.xml?key=01QcdA8pt51gOUi4UJj6A"
                    dic = Nokogiri::HTML(open(url))
                    place = dic.xpath("//location").text
                    
                    city = Geocoder.coordinates dic.xpath("//location").text
                    if city.nil? 
                        city === [0, 0]
                    end
                    # end
                    name = dic.xpath("//name")[0].text 
                    # unless y.nil? || y === [37.09024, -95.712891]
                    
                    # end
                    # unless y.nil? || y === [37.09024, -95.712891]

                    # end
                    user = User.where(id: id).first_or_create(location: city, name: name)
                    user.groups << group_record
                  rescue
                  end
                end
            end
        end 
    end
end  

