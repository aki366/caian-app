require 'rails_helper'

RSpec.describe 'UsersNew', type: :system do

  describe 'ユーザーの新規登録をするとき' do
    context 'フォームの入力値が正常な場合' do
      it 'ユーザーが作成できること' do
        # 新規ユーザー登録画面にアクセス
        # フォームへテキストを入力
        # 新規登録ボタンをクリックするとユーザーが作成される
        # ユーザー詳細画面へ遷移する
        # メッセージが表示される
      end
    end
    context 'メールアドレスが未入力の場合' do
      it 'ユーザーが作成できないこと' do
      end
    end
    context '登録済のメールアドレスを使用した場合' do
      it 'ユーザーが作成できないこと' do
      end
    end
  end
end
