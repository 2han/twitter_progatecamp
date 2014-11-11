class Tweet < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, length: { maximum: 140 }
  has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user
   # データベースから実際に、自分と、自分のフォローしているユーザーのTweetを取得
  def self.from_users_followed_by(user)
# userっていうにはcurrent_user

# following_idsの中に、current_usersがフォローがフォローしている人のusers_idの一覧がusers_idsに入ります
    following_ids = user.following_ids
    where("user_id IN (?) OR user_id = ?", following_ids, user)
  end
end