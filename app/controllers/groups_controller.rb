class GroupsController < ApplicationController
  # require 'rubygems'  require 'nokogiri'
  # require 'open-uri'

  def index
    @groups = current_user.groups 
  #   client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
  #   @group_list = client.group_list(@user.id, 'sort')
  
  #   @groups = @user.groups
    respond_to do |format|
      format.html 
      format.json do 
        render json: {
          groups_status: groups_status,
          group_total: current_user.group_total, 
          groups: current_user.groups.map do |g|
            { title: g.title,
              url: group_url(g),
              status: g.status }
          end
        }
      end
    end
  end


  def show
    @group = Group.find(params[:id])
    @members = @group.members.includes(:location)


    #client = Goodreads::Client.new(oauth_token: current_user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
    #@group_list = client.group_list(current_user.id, 'sort')
    #@group = Group.find_by_id(params[:id])
    #redirect_to(listgroups_path, :notice => 'Still Getting Data From Goodreads') unless @group

    # answer = []
    # @group_list.group.each { |g| answer.push(g.to_a.flatten) unless g.title != @group.title }
    # answer = answer.flatten
    # @percent_loaded = (((@group.users.count/answer[5].to_f)*100).to_i).to_s + '%'
  end

  private 
    def groups_status
      if current_user.group_total == current_user.groups.where(status: "populated").count
        "done"
      else
        "fetching"
      end
    end
end
