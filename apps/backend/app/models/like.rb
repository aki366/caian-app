class Like < ApplicationRecord
  
  validates :user_id, {presence: true}
  validates :ticket_id, {presence: true}
  belongs_to :user
  belongs_to :ticket
end
