# Member Populate Status

- In GroupCreator, store member_count in Group model on database
- in groups/index, display <group.members.count> / <group.member_total>
	- update groups.json (groups_controller#index respond_to json)
		- add returning off member_total
		- add returning off populated_member_count (group.members.count)
	- update JS in groups/index.js
	- update tempalte in groups/index.html.eb
- add javascript plugin to update an actual progress bar


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

TODO for completion:
- Remove console.log
- Test with another user
- Handle users without specified location
- Save locations in database and then alter duplicate locations in the view
- Actually get pagination working
- Optimize calls
- Updating template to have nicer style
- If you remove yourself from a group within GoodReads, update in app
- Do not repopulate on every login (manual refresh?)

FUTURE:
- Use react template instead?
- Progress bar or updated count if members populated vs members total
