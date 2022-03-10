class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  validates :name, {presence:true}

  validates :email, {presence: true,uniqueness:true}

  validates :password, {presence: true}

  #TODO: ゲストかどうか判別するメソッドを定義
  def guest?
    self.email == "guest@example.com"
  end
end
