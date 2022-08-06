class Team < ApplicationRecord

  validates :name, {presence: true, length: {maximum: 50}}

  has_many :members, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :users, through: :members, dependent: :destroy

  has_many :members
  has_many :users, through: :members

  belongs_to :room
end
