class Post < ApplicationRecord
  has_one_attached :image
  #ちなみに複数の場合は has_many_attached :images になります。

  validates :content, {presence: true,length: {maximum: 140}}
  validates :user_id, {presence: true}
  
  def user
    return User.find_by(id: self.user_id)
  end

end
