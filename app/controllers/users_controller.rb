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
    # client = Goodreads::Client.new(GOODREADS_API_KEY => 'UpIly3BURwhZ52tmj4ag',
    # GOODREADS_API_SECRET => 'vIlBCRroZ5Esfn4RRQxY7Sd8sfOx7wOvtWY6thJfqQ')
    # #  consumer = OAuth::Consumer.new(GOODREADS_API_KEY,
    # #                                GOODREADS_API_SECRET,
    # #                                :site => 'http://www.goodreads.com')
    # # access_token = OAuth::AccessToken.new(consumer, oauth_access_token, oauth_access_secret)
    # # Goodreads::Client.new(oauth_token: access_token, api_key: GOODREADS_API_KEY, api_secret: GOODREADS_API_SECRET)
    Goodreads::Client.new(api_key: GOODREADS_API_KEY, api_secret: GOODREADS_API_SECRET)
    @reviews = client.book_by_title("Steve Jobs")
  end

# def client
#     consumer = OAuth::Consumer.new(GOODREADS_API_KEY,
#                                    GOODREADS_API_SECRET,
#                                    :site => 'http://www.goodreads.com')
#     # access_token = OAuth::AccessToken.new(consumer, oauth_access_token, oauth_access_secret)
#     Goodreads::Client.new(api_key: GOODREADS_API_KEY, api_secret: GOODREADS_API_SECRET)
#   end

  def show
  end

end
