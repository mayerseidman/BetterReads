class UsersController < ApplicationController
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
  def new
    @user = User.all.find(params[:id])
  end

  def create
  end

  def update
  end
 
  def edit
  end

  def destroy
  end

  def index
    client = Goodreads::Client.new(oauth_token: "ALIVGfWdLZYkh34NIKzVmw", api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
     @reviews = client.book_by_title("Moby Dick")
     @group_list = client.group_list(current_user.uid, 'sort')
      # @group = client.group(106427)
      # @members = @group.group_members

    url = "https://www.goodreads.com/group/#{@group_list.group[0].id}/members?format=xml&key=#{client.api_key}"
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
    group.each do |id|
      begin
        url = "https://www.goodreads.com/user/show/#{id}.xml?key=01QcdA8pt51gOUi4UJj6A"
        dic = Nokogiri::HTML(open(url))
        x = dic.xpath("//name")[0].text || "no name"
        @name << x
        y = Geocoder.coordinates dic.xpath("//location").text
        if y.nil? 
          y = [0,0]
        end
        @city << y
      rescue
      end
    end
    @fun = Geocoder.coordinates @city[2]

    @location = @group.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }


  end

def client
    consumer = OAuth::Consumer.new(GOODREADS_API_KEY,
                                   GOODREADS_API_SECRET,
                                   :site => 'http://www.goodreads.com')
     access_token = OAuth::AccessToken.new(consumer, oauth_access_token, oauth_access_secret)
    Goodreads::Client.new(oauth_token: "ALIVGfWdLZYkh34NIKzVmw", api_key: GOODREADS_API_KEY, api_secret: GOODREADS_API_SECRET)
  end

  def show
  end

end
