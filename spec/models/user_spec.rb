require 'rails_helper'

RSpec.describe User, type: :model do

  it '名前がない場合無効' do
    @user = FactoryBot.build(:user, name: nil)
    @user.valid?
    expect(@user.errors.full_messages).to include('Nameを入力してください')
  end

  it 'メールアドレスがない場合無効' do
    @user = FactoryBot.build(:user, email: nil)
    @user.valid?
    expect(@user.errors.full_messages).to include('Emailを入力してください')
  end

  it 'パスワードがない場合無効' do
    @user = FactoryBot.build(:user, password: nil)
    @user.valid?
    expect(@user.errors.full_messages).to include('Passwordを入力してください')
  end

  it '名前が30文字以下の場合有効' do
    text = 'a' * 30
    @user = FactoryBot.build(:user, name: text)
    @user.valid?
    expect(@user).to be_valid
  end

  it '名前が31文字以上の場合無効' do
    text = 'a' * 31
    @user = FactoryBot.build(:user, name: text)
    @user.valid?
    expect(@user.errors.full_messages).to include('Nameは30文字以内で入力してください')
  end

  it '同じメールアドレスの場合無効' do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user, email: @user.email)
    @user2.valid?
    expect(@user2.errors.full_messages).to include('Emailはすでに存在します')
  end

  it 'メールアドレスの大文字と小文字が違う場合有効' do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user, email: @user.email.upcase)
    @user2.valid?
    expect(@user2).to be_valid
  end

  it 'メールアドレスの形が不正の場合無効' do
    @user = FactoryBot.build(:user, email: '456-9333')
    @user.valid?
  end
end
