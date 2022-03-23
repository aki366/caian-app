class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  validates :name, {presence:true}

  validates :email, {presence: true,uniqueness:true}

  validates :password, {presence: true}

  # Postモデルとのアソシエーションを作成
  # Userのインスタンスはpostsメソッドを使えるようになる
  # UserモデルはPostモデルをたくさん持っていて（1対多の関係）
  # モデル同士の関係を表現するものなので、二つでセットそのため、app/models/post.rbファイルではbelongs_to :userと定義している。
  # @user.posts
  has_many :posts

  # ゲストかどうか判別するメソッドを定義
  def guest?
    self.email == "guest@example.com"
  end
end
