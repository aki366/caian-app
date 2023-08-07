class Team < ApplicationRecord
  validates :name, {presence: true, length: {maximum: 50}}

  has_many :members, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :team_messages, dependent: :destroy
  has_many :users, through: :members
end
