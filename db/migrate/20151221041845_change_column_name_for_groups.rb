class ChangeColumnNameForGroups < ActiveRecord::Migration
  def change
  	rename_column :groups, :group_users_count, :num_members
  end
end
