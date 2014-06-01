class GroupsController < ApplicationController
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  def index
    # @user = user.find(params[:oauth_token])
    client = Goodreads::Client.new(oauth_token: 'current_user.oauth_token', api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: 'current_user.oauth_secret')
    @group_list = client.group_list(current_user.uid, 'sort')
    @group_list.group.each do |g| 
  
    @group_id = g.id 
  end
  end

  def show
    client = Goodreads::Client.new(oauth_token: 'current_user.oath_token', api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: 'current_user.oauth_secret')
     @reviews = client.book_by_title("Moby Dick")
     @group_list = client.group_list(current_user.uid, 'sort')
      # @group = client.group(106427)
      # @members = @group.group_members

    url = "https://www.goodreads.com/group/#{params[:id]}/members?format=xml&key=#{client.api_key}"
    doc = Nokogiri::HTML(open(url))
    group = doc.xpath("//id").map{ |tr| tr.xpath("//id").map(&:text) }[0]
    @group = group
    # group.map do |id| 
    #   begin
    #     url = "https://www.goodreads.com/user/show/#{id}.xml?key=#{client.api_key}"
    #     dic = Nokogiri::HTML(open(url))
    #     dic.xpath("//location").text.titleize 
    #     # dic.xpath("//name")[0].text
    #   rescue
    #   end
    # end
    @name = []
    @city = []
    @id = []
    group.each do |id|
      begin
        url = "https://www.goodreads.com/user/show/#{id}.xml?key=01QcdA8pt51gOUi4UJj6A"
        dic = Nokogiri::HTML(open(url))
        @place = dic.xpath("//location").text
        
        y = Geocoder.coordinates dic.xpath("//location").text
        unless y.nil? || y === [37.09024, -95.712891]
          @city << y
        end
        x = dic.xpath("//name")[0].text 
        unless y.nil? || y === [37.09024, -95.712891]
          @name << x
        end
        unless y.nil? || y === [37.09024, -95.712891]
          @id << id
        end
      rescue
      end
    end
    @fun = Geocoder.coordinates @city[2]

    @location = @group.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }


  end
end
