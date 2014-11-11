class User < ActiveRecord::Base
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :tweets, dependent: :destroy
  # フォローしている
  has_many :following_relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :following_relationships
  #フォローされている
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  # # お気に入りしている
  # has_many :favorites_relationships, foreign_key: "favorites_id", class_name: "Relationship", dependent: :destroy
  # has_many :favorites, through: :favorites_relationships
  # # お気に入りされている
  # has_many :favorited_relationships, foreign_key: "favorited_id", class_name: "Relationship", dependent: :destroy
  # has_many :favorited, through: :favorited_relationships
  has_many :favorites
  has_many :favorite_tweets, through: :favorites, source: :tweet

  def set_image(file)
    if !file.nil?
    # ファイル名
    file_name = file.original_filename
    #画像をアップロード
    File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
    #データベースにファイル名を保存するため
    self.image = file_name
    end
  end

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
# お気に入りしているか？か調べる
  def favorite?(tweet)
    favorites.find_by(tweet_id: tweet.id)
  end

  def favorite!(tweet)
    favorites.create!(tweet_id: tweet.id)
  end

  def unfavorite!(tweet)
    favorites.find_by(tweet_id: tweet.id).destroy
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Tweet.from_users_followed_by(self)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end


# VALID_EMAIL_REGEXの説明　regex レギューラーエクス　正規表現の検証　「基本的にGoogleでメールアドレス　正規表現」
# モデル内部
# validates :カラム名（第一引数）,バリデーションの中身（第二引数以下）
# presence: true　値が入っているかを調べる
# uniqueness: true　そのことが固有なものかどうか調べる（例えば、登録メールアドレスの重複をしないようにするために使用する）
# 重複したら、エラーを返す