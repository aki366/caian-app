class Ticket < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 1000}}
  validates :user_id, {presence: true}

  # ActiveStorage用のカラムをticketモデルに追加する
  # この記述で、@ticket.imageで画像を呼び出すことができる
  has_one_attached :image
  # 複数形の場合 has_many_attached :images

  # Userモデルとのアソシエーションを作成
  # Ticketモデルのインスタンスがuserメソッドを使えるようになる
  # @Ticket.user
  belongs_to :user

  # ticketが複数のlikeを所有している関係
  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

end
