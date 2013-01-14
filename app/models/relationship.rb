# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :string(255)
#  integer     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end