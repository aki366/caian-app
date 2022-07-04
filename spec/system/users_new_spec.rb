require 'rails_helper'

RSpec.describe 'UsersNew', type: :system do

  describe 'ユーザーの新規登録をするとき' do
    context 'フォームの入力値が正常な場合' do
      it 'ユーザーが作成できること' do
        # 新規ユーザー登録画面にアクセス
        visit new_user_path
        # 全てのフォームへ正常な値を入力
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
        # 新規ユーザー登録画面にアクセス
        visit new_user_path
        # メールフォームの値のみnil
        fill_in 'user_name',     with: 'system_山田'
        fill_in 'user_email',    with: ''
        fill_in 'user_password', with: 'password'
        # 新規登録ボタンをクリックしてもユーザーが作成されない
        expect { click_button '新規登録' }.to change { User.count }.by(+0)
        # 新規ユーザー登録画面にリダイレクトされる
        expect(users_path).to eq new_user_path
        # メッセージが表示される
        expect(user.errors.full_messages).to include('Emailを入力してください')
        # expect(page).to have_content 'Emailを入力してください'
      end
    end
    context '登録済のメールアドレスを使用した場合' do
      it 'ユーザーが作成できないこと' do
        # 新規ユーザー登録画面にアクセス
        # メールフォームに登録済のメールアドレスを入力
        # 新規登録ボタンをクリックしてもユーザーが作成されない
        # 新規ユーザー登録画面にリダイレクトされる
        # メッセージが表示される
      end
    end
  end
end
