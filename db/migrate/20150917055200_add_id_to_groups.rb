class AddIdToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :goodreads_id, :integer
  end
end
