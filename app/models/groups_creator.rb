class GroupsCreator
	def initialize(user)
		@user = user
	end

	# Creates all groups for given user with state 'ready'
	def create_groups!
		client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
		group_list = client.group_list(@user.id, 'sort')
		group_list.group.map do |g|
			group = Group.find_or_create_by(
				goodreads_id: g.id
			)
			group.title = g.title
			unless group.users.include? @user
				group.users << @user
			end
			group.save!
			group 
		end
	end
end