class Post < ApplicationRecord
  has_one_attached :image
  # has_many_attached 複数のファイルが添付可能。
  
  validates :content, {presence: true,length: {maximum: 140}}
  validates :user_id, {presence: true}
  
  def user
    return User.find_by(id: self.user_id)
  end

end
