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
            user.coordinates = (Geocoder.coordinates auth["info"]["location"]).to_s
            user.city = auth["info"]["location"]
            user.save!
        end  
    end

    def alert(id)
        @user = User.find(id)
        client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
        @group_list = client.group_list(@user.id, 'sort')

        unless @group_list.group.nil? 
            @group_list.group.each do |g|
                x = g.users_count.to_i/10 
                1.upto(x) do |n|
                    url = "https://www.goodreads.com/group/#{g.id}/members?format=xml&key='UpIly3BURwhZ52tmj4ag'&page=#{n}"
                    doc = Nokogiri::HTML(open(url))
                    group = doc.xpath("//id").map{ |tr| tr.xpath("//id").map(&:text) }[0]
                  
                    @group_record = Group.where(id: g.id).first_or_create(title: g.title)

                    unless g.users_count.to_i <= @group_record.users.count
                        group.each do |id|
                          begin
                            sleep 2
                            url = "https://www.goodreads.com/user/show/#{id}.xml?key=01QcdA8pt51gOUi4UJj6A"
                            dic = Nokogiri::HTML(open(url))
                            @name = dic.xpath("//name")[0].text
                            place = dic.xpath("//location").text
                            location = Location.where(city: place).first_or_create(coordinates: (Geocoder.coordinates place).to_s)
                            coordinates = location.coordinates
                            if coordinates.present? && coordinates != "[37.09024, -95.712891]"
                                def check_location
                                    if @group_record.users.collect {|u| u.location}.include?(coordinates)
                                        coordinates = coordinates.sub(coordinates[5], coordinates[5].next)
                                        check_location
                                    end
                                end
                                check_location
                        
                                user = User.where(id: id).first_or_create(name: @name, coordinates: coordinates, city: location.city)
                                
                                unless user.groups.include?(@group_record)
                                    user.groups << @group_record
                                end
                                user.save!
                            end
                          rescue
                          end
                        end
                    end    
                
                end
                unless @user.groups.include?(@group_record)
                    @user.groups << @group_record
                    @user.save!
                end
            end
        end 
    end
end  
