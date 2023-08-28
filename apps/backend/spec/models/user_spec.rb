require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe '#create' do
    context '名前が30文字以下のとき' do
      before { user.name = 'a' * 30 }

      it '登録が成功すること' do
        user.valid?
      end
    end

    context '名前が31文字以上のとき' do
      before { user.name = 'a' * 31 }

      it '登録が失敗すること' do
        user.valid?
      end
    end

    context '名前がないとき' do
      before { user.name = '' }

      it '登録が失敗すること' do
        user.valid?
      end
    end

    context 'メールアドレスの大文字と小文字が違うとき' do
      let!(:other_user) { build(:user, email: user.email.upcase) }

      it '登録が失敗すること' do
        other_user.valid?
        expect(other_user).to_not be_valid
      end
    end

    context 'メールアドレスがないとき' do
      before { user.email = '' }

      it '登録が失敗すること' do
        user.valid?
      end
    end

    context 'メールアドレスがすでに登録されているとき' do
      let!(:other_user) { create(:user) }

      it '登録が失敗すること' do
        other_user.valid?
      end
    end

    context 'メールアドレスの形が不正のとき' do
      before { user.email = '456-9333' }

      it '登録が失敗すること' do
        user.valid?
      end
    end

    context 'パスワードがないとき' do
      before { user.password = '' }

      it '登録が失敗すること' do
        user.valid?
      end
    end
  end
end
