class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  validates :name, {presence: true, length: {maximum: 30}}
  validates :email, {presence: true, uniqueness:true, length: {maximum: 256}}
  validates :password, {presence: true, length: {maximum: 30}, if: ->(record) { record.new_record? || record.password.present? }}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_secure_password

  # throughは、特定のユーザー何と紐づいているか一発で引くことができる
  # roomsとroom_usersが紐づいて、複数のroom_usersとuserが紐づくイメージ
  has_many :rooms, through: :room_users

  # ゲストかどうか判別するメソッドを定義
  def guest?
    self.email == "guest@example.com"
  end

  def posts
    return Post.where(user_id: self.id)
  end
end
