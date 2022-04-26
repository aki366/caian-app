require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規ユーザー登録' do
    context '登録がうまくいくとき' do
      it '名前が30文字以下の場合' do
        @user.name = 'a' * 30
        @user.valid?
      end
      it 'メールアドレスの大文字と小文字が違う場合' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.build(:user, email: @user.email.upcase)
        @user2.valid?
        expect(@user2).to be_valid
      end
    end

    context '登録がうまくいかないとき' do
      it '名前がない場合' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nameを入力してください')
      end
      it 'メールアドレスがない場合' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Emailを入力してください')
      end
      it 'パスワードがない場合' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordを入力してください')
      end
      it '名前が31文字以上の場合' do
        @user.name = 'a' * 31
        @user.valid?
        expect(@user.errors.full_messages).to include('Nameは30文字以内で入力してください')
      end
      it '同じメールアドレスの場合' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.build(:user, email: @user.email)
        @user2.valid?
        expect(@user2.errors.full_messages).to include('Emailはすでに存在します')
      end
      it 'メールアドレスの形が不正の場合' do
        @user.email = '456-9333'
        @user.valid?
      end
    end
  end
end
