class UsersController < ApplicationController

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
    @user = User.first
    client = Goodreads::Client.new(oauth_token: "ALIVGfWdLZYkh34NIKzVmw", api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
     # @reviews = client.book_by_title("Moby Dick")
     @group_list = client.group_list(11807848 , 'sort')
      # @group = client.group(106427)
      # @members = @group.group_members

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
