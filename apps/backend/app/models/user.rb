class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  validates :name, {presence: true, length: {maximum: 30}}
  validates :email, {presence: true, uniqueness:true, length: {maximum: 256}}
  validates :password, {presence: true, length: {maximum: 30}, if: ->(record) { record.new_record? || record.password.present? }}

  
  has_many :tickets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :team_messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_secure_password

  has_many :rooms, through: :room_users
  has_many :teams, through: :members

  # ゲストかどうか判別するメソッドを定義
  def guest?
    self.email == "guest@example.com"
  end
end
