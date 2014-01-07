class School < ActiveRecord::Base
  validates :name, :email, :user_id, :presence => true
  belongs_to :user
end
