require 'rails_helper'

RSpec.describe 'UsersNew', type: :system do

  describe 'ユーザーの新規登録をするとき' do
    context 'フォームの入力値が正常な場合' do
      it 'ユーザーが作成できること' do
        # 新規ユーザー登録画面にアクセス
        visit new_user_path
        # フォームへテキストを入力
        fill_in 'user_name',     with: 'system_山田'
        fill_in 'user_email',    with: 'system@example.com'
        fill_in 'user_password', with: 'password'
        # 新規登録ボタンをクリックするとユーザーが作成される
        expect { click_button '新規登録' }.to change { User.count }.by(+1)
        # ユーザー詳細画面へ遷移する
        expect(users_path).to eq users_path
        # メッセージが表示される
        expect(page).to have_content 'ユーザー登録が完了しました'
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
