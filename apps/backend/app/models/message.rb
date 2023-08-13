class Message < ApplicationRecord
  validates :text, {presence: true, length: {maximum: 1000}}

  belongs_to :room
  belongs_to :user
end
