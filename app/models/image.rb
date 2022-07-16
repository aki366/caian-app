class Image < ApplicationRecord
  belongs_to :ticket
  attachment :image
end
