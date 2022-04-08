class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  validates :name, {presence:true}
  validates :email, {presence: true,uniqueness:true}
  validates :password, {presence: true}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages
  has_many :room_users

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
