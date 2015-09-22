class AddCoLatLongColumsToLocations < ActiveRecord::Migration
  def change
  	remove_column :locations, :coordinates
  	add_column :locations, :latitude, :decimal
  	add_column :locations, :longitude, :decimal
  end
end
