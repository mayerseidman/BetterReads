class GroupsCreator
	def initialize(user)
		@user = user
	end

	# Creates all groups for given user with state 'ready'
	def create_groups!
		client = Goodreads::Client.new(oauth_token: @user.oauth_token, api_key: 'UpIly3BURwhZ52tmj4ag', api_secret: GOODREADS_API_SECRET)
		group_list = client.group_list(@user.id, 'sort')
		groups = group_list.group.map do |g|
			group = Group.find_or_create_by(
				goodreads_id: g.id
			)
			group.title = g.title
			group.num_members = g.users_count
			unless group.users.include? @user
				group.users << @user
			end
			group.save!
			group 
		end
		@user.group_total = group_list.group.count
		@user.save!
		return groups 
	end

	def create_and_populate!
		groups = create_groups!
		groups.map do |group|
			MemberPopulator.new(group).delay.populate
		end
	end
end