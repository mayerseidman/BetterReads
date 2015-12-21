class AddTotalUsersToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :group_users_count, :integer
  end
end
