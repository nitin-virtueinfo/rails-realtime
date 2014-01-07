class School < ActiveRecord::Base
  validates :name, :email, :owner, :user_id, :presence => true
  belongs_to :user
end
