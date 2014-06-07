class GroupsController < ApplicationController
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  def index
    @user = User.find(current_user.id)
    client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
    @group_list = client.group_list(@user.id, 'sort')

    unless @group_list.group.nil?
      @group_list.group.each do |g| 
    
        @group_id = g.id 
      end
    end
  
   @user.delay.alert 


  end



  def show

    @group = Group.find(params[:id])
   
  end
end
