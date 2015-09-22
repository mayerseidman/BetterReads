# BetterReads Plan

- Upon login
	- create groups in database, with state: 'initial'
		- GroupsCreator.new(user).create
	- launch background job for each group, to fetch users and locations

- Background Job: PopulateGroup
	- (For a given group)
	- Fetch all user IDs from GoodReads API
	- For each user ID, hit URL to get location from GoodReads
	- Store user and location in database
	- When done with all users, update group state to 'done'

- Group #show page
	- Should now use users and locations stored in database

- Group #index tweaks
	- Show icon indicating if state is 'initial' or 'done'
	- Bonus Points: ajax update/polling when done
	- Extra bonus points: store total # of users in database, and current number of users fetched, show progress bar

- Potentially creating pagination

=> Add members to group