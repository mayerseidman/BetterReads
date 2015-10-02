class AddNumberOfGroupsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :group_total, :integer
  end
end
