class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :follower_id, presence: true
  validates :following_id, presence: true

  # belongs_to :favorited, class_name: "User"
  # belongs_to :favorites, class_name: "User"
  # validates :favorited_id, presence: true
  # validates :favorites_id, presence: true

end