class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :city, :coordinates
  	rename_column :users, :location, :city
  end
end
