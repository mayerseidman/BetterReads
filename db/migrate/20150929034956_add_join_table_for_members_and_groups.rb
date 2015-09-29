class AddJoinTableForMembersAndGroups < ActiveRecord::Migration
  def change
  	create_table :groups_members do |t|
  		t.references :group 
  		t.references :member 
  	end
  end
end
