require 'rails_helper'

RSpec.describe User, type: :model do

  it '名前がない場合無効。' do
    @user = FactoryBot.build(:user, name: nil)
    @user.valid?
  end

end
