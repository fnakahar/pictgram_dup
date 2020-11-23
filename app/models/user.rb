class User < ApplicationRecord

  # アルファベットと数字の混合で、最低1文字はどちらも使わなければいけない。小文字大文字は区別しない
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  # xxx@yyy.zzz の形式のみ受け付ける
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 15}
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: { minimum: 8, maximum: 32}, format: { with: VALID_PASSWORD_REGEX}
  validates :password_confirmation, presence: true, length: { minimum: 8, maximum: 32}, format: { with: VALID_PASSWORD_REGEX}

  # 送信されたパスワードを暗号化した上で、テーブルのpassword_digestというカラムに格納する
  has_secure_password
end
