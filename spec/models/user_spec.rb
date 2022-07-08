require 'rails_helper'

RSpec.describe "Users Model", type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '#create' do
    context '名前が30文字以下のとき' do
      it '登録が成功すること' do
        @user.name = 'a' * 30
        @user.valid?
      end
    end
    context '名前が31文字以上のとき' do
      before do
        @user.name = 'a' * 31
      end
      it '登録が失敗すること' do
        @user.valid?
      end
      it 'エラーメッセージが表示されること' do
        @user.valid?
        expect(@user.errors.full_messages).to include('Nameは30文字以内で入力してください')
      end
    end
    context '名前がないとき' do
      before do
        @user.name = ''
      end
      it '登録が失敗すること' do
        @user.valid?
      end
      it 'エラーメッセージが表示されること' do
        @user.valid?
        expect(@user.errors.full_messages).to include('Nameを入力してください')
      end
    end
    context 'メールアドレスの大文字と小文字が違うとき' do
      it '登録が成功すること' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.build(:user, email: @user.email.upcase)
        @user2.valid?
        expect(@user2).to be_valid
      end
    end
    context 'メールアドレスがないとき' do
      before do
        @user.email = ''
      end
      it '登録が失敗すること' do
        @user.valid?
      end
    end
    context 'メールアドレスがすでに登録されているとき
    ' do
      before do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.build(:user, email: @user.email)
      end
      it '登録が失敗すること' do
        @user2.valid?
      end
    end
    context 'メールアドレスの形が不正のとき' do
      it '登録が失敗すること' do
        @user.email = '456-9333'
        @user.valid?
      end
    end
    context 'パスワードがないとき' do
      before do
        @user.password = ''
      end
      it '登録が失敗すること' do
        @user.valid?
      end
      it 'エラーメッセージが表示されること' do
        # @user.valid?
        # expect(@user.errors.full_messages).to include('Passwordを入力してください')
      end
    end
  end
end
