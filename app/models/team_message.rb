class TeamMessage < ApplicationRecord
  validates :text, {presence: true, length: {maximum: 1000}}

  belongs_to :team
  belongs_to :user
end
