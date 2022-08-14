class Categorle < ApplicationRecord

  has_many :ticket_categorles, dependent: :destroy
  has_many :tickets, through: :ticket_categorles

end
