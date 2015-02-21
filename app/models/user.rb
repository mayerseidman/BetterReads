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

    def alert(group_id)
        # I got a group selection with a given id.
        # I need to go to Goodreads URL and ask for the members of that group.
        # grab the id of each member to see that user profile
        #   I need to get the location and the name for that user
        #   With the location, I want to get the coordinates of the locations
        #  Then we map out on the map where the coordinates are = the city 

        # TODO: check if the group_id exists and return

        client = Goodreads::Client.new(oauth_token: self.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)

        # get users for group_id
        n = 10
        url = "https://www.goodreads.com/group/#{group_id}/members?format=xml&key='UpIly3BURwhZ52tmj4ag'" # &page=#{n}
        doc = Nokogiri::HTML(open(url))
        users = doc.xpath("//user/id").map(&:text)
        # gets the profile for each user
        my_users = []
        users.each do |user|
          profile_url = "https://www.goodreads.com/user/show/#{user}.xml?key=01QcdA8pt51gOUi4UJj6A"
      
          dic = Nokogiri::HTML(open(profile_url))
          name = dic.xpath("//name")[0].text
          place = dic.xpath("//location").text
          location = Location.where(city: place).first_or_create(coordinates: (Geocoder.coordinates place).to_s)
          coordinates = location.coordinates
          my_users << {id: user, name: name, place: place, city: location.city, coordinates: coordinates}
        end

        group = Group.where(id: group_id).first
        unless group
          # get group profile
          goodreader_group = client.group_list(self.id, 'sort').group.select{|item| item.id == group_id}
          title = goodreader_group.first.title
          group = Group.create(id: group_id, title: title)        
        end

        my_users.each do |user|
          db_user = User.where(id: user[:id]).first
          if db_user.nil?
            if user[:coordinates].present? && user[:coordinates] != "[37.09024, -95.712891]"
                               
              def check_location(group, user)
                  if group.users.collect {|u| u.coordinates}.include?(user[:coordinates])
                      s2 = user[:coordinates][-4].succ
                      user[:coordinates][-4] = s2
                   
                      check_location(group, user)
                  end
              end

              check_location(group, user)
            end
            db_user = User.create(
              id: user[:id],
              name: user[:name],
              coordinates: user[:coordinates],
              city: user[:city]
            )
          end
          
          if !db_user.groups.include?(group)
            db_user.groups << group
            # group.users << user
          end 
        end

        return my_users


        #byebug
#         @user = User.find(id)
#         client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
#         @group_list = client.group_list(@user.id, 'sort')
# puts "ola"
#         unless @group_list.group.nil? 
#             @group_list.group.each do |g|
#                 x = g.users_count.to_i/10 
#                 1.upto(x) do |n|
#                     url = "https://www.goodreads.com/group/#{g.id}/members?format=xml&key='UpIly3BURwhZ52tmj4ag'&page=#{n}"
#                     doc = Nokogiri::HTML(open(url))
#                     group = doc.xpath("//id").map{ |tr| tr.xpath("//id").map(&:text) }[0]
                  
#                     #byebug
#                     @group_record = Group.where(id: g.id).first_or_create(title: g.title)

#                     unless g.users_count.to_i <= @group_record.users.count
#                         group.each do |id|
#                             user = User.where(id: id).first
#                             if user
#                                 puts "already exists"
#                                 unless user.groups.include?(@group_record)
#                                     user.groups << @group_record
#                                     user.save!
#                                 end
#                                 next
#                             else
#                                 puts "new user"    
#                             end
#                           begin
#                             sleep 1

#                             @url = "https://www.goodreads.com/user/show/#{id}.xml?key=01QcdA8pt51gOUi4UJj6A"
#                             dic = Nokogiri::HTML(open(@url))
#                             @name = dic.xpath("//name")[0].text
#                             place = dic.xpath("//location").text
#                             location = Location.where(city: place).first_or_create(coordinates: (Geocoder.coordinates place).to_s)
#                             @coordinates = location.coordinates
                            
#                             if @coordinates.present? && @coordinates != "[37.09024, -95.712891]"
                               
#                                 def check_location
#                                     if @group_record.users.collect {|u| u.coordinates}.include?(@coordinates)
#                                         s2 = @coordinates[-4].succ
#                                         @coordinates[-4] = s2
                                     
#                                         check_location
#                                     end
#                                 end

#                                 check_location
#                                 user = User.where(id: id).first_or_create(name: @name, coordinates: @coordinates, city: location.city)
                                
#                                 unless user.groups.include?(@group_record)
#                                     user.groups << @group_record
#                                 end
#                                 user.save!
#                             else
#                                 puts "no location"
#                             end
#                           rescue OpenURI::HTTPError => e 
#                             puts "404 again #{@url}"
#                           rescue Exception => e 
#                             puts "## error #{e.message}"
#                           end
#                         end
#                     end    
                
#                 end
#                 unless @user.groups.include?(@group_record)
#                     @user.groups << @group_record
#                     @user.save!
#                 end
#             end
#         end 
    end
end  
