class GroupsController < ApplicationController
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  def index
    @user = User.find(current_user)
    client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
    @group_list = client.group_list(@user.id, 'sort')

    # unless @group_list.group.nil?
    #   @group_list.group.each do |g| 
    
    #     @group_id = g.id 
    #   end
    # end
  
    @groups = @user.groups
  end

  def send_alert
    
  end



  def show
    @users = current_user.alert(params[:id])


    #client = Goodreads::Client.new(oauth_token: current_user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
    #@group_list = client.group_list(current_user.id, 'sort')
    #@group = Group.find_by_id(params[:id])
    #redirect_to(listgroups_path, :notice => 'Still Getting Data From Goodreads') unless @group

    # answer = []
    # @group_list.group.each { |g| answer.push(g.to_a.flatten) unless g.title != @group.title }
    # answer = answer.flatten
    # @percent_loaded = (((@group.users.count/answer[5].to_f)*100).to_i).to_s + '%'
  end
end
