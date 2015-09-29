class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :members

  before_create :set_status

  def set_status 
  	self.status = "created"	
  end
end
