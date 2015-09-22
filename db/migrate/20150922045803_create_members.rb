class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :goodreads_id
      t.integer :location_id
      t.string :name

      t.timestamps
    end
  end
end
