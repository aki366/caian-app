class Message < ApplicationRecord
  validates :message_text, {presence: true, length: {maximum: 140}}

  belongs_to :room
  belongs_to :user
end
