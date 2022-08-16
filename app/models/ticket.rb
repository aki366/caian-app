class Ticket < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 1000}}
  validates :subject, {presence: true, length: {maximum: 100}}
  validates :user_id, {presence: true}

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ticket_categorles, dependent: :destroy

  has_many :categorles, through: :ticket_categorles

  belongs_to :user

  # ActiveStorage用のカラム
  # 複数形の場合 has_many_attached :images
  has_one_attached :image

end
