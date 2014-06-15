class GroupsController < ApplicationController
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  def index
    @user = User.find(current_user)
    client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
    @group_list = client.group_list(@user.id, 'sort')
    @groups = @user.groups

  end



  def show
    @group = Group.find_by_id(params[:id])
    redirect_to(listgroups_path, :notice => 'Still Getting Data From Goodreads') unless @group
  end
end
