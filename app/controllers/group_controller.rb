class GroupController < ApplicationController
  def index
    client = Goodreads::Client.new(oauth_token: "ALIVGfWdLZYkh34NIKzVmw", api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
    @group_list = client.group_list(current_user.uid, 'sort')

    @group_list.group.each do |g|
  @group_id = g.id                 # => group id
  g.access             # => access settings (private, public)
  g.users_count        # => number of members
  @group_title = g.title              # => title
  g.image_url          # => url of the group's image
  g.last_activity_at   # => date and time of the group's last activity
end
  end

  def show
  end
end
