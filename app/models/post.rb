class Post < ApplicationRecord
  validates :content, {presence: true,length: {maximum: 140}}
  validates :user_id, {presence: true}

  # ActiveStorage用のカラムをpostモデルに追加する
  # この記述で、@post.imageで画像を呼び出すことができる
  has_one_attached :image
  # 複数形の場合 has_many_attached :images

  # Userモデルとのアソシエーションを作成
  # Postモデルのインスタンスがuserメソッドを使えるようになる
  # @post.user
  belongs_to :user
  
  def user
    return User.find_by(id: self.user_id)
  end

end
