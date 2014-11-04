class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :tweets

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
end
# VALID_EMAIL_REGEXの説明　regex レギューラーエクス　正規表現の検証　「基本的にGoogleでメールアドレス　正規表現」
# モデル内部
# validates :カラム名（第一引数）,バリデーションの中身（第二引数以下）
# presence: true　値が入っているかを調べる
# uniqueness: true　そのことが固有なものかどうか調べる（例えば、登録メールアドレスの重複をしないようにするために使用する）
# 重複したら、エラーを返す