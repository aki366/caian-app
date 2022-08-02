class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  # ルームを削除した時に中間テーブルの情報も削除
  has_many :messages, dependent: :destroy
  has_many :users, through: :room_users, dependent: :destroy

  has_many :teams
end
