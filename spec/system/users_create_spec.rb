require 'rails_helper'

RSpec.describe 'Users #create system', type: :system do

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
        expect { click_on '新規登録' }.to change { User.count }.by(1)
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
        expect { click_on '新規登録' }.to change { User.count }.by(0)
        # エラーメッセージが表示されること
        expect(page).to have_content 'Emailを入力してください'
        # 新規ユーザー登録画面にリダイレクトされる
        visit new_user_path
      end
    end
    context '登録済のメールアドレスを使用した場合' do
      let(:user) { create(:user) }
      it 'ユーザーが作成できないこと' do
        # 新規ユーザー登録画面にアクセス
        visit new_user_path
        # メールフォームに登録済のメールアドレスを入力
        fill_in 'user_name',     with: 'system_山田'
        fill_in 'user_email',    with: user.email
        fill_in 'user_password', with: 'password'
        # 新規登録ボタンをクリックしてもユーザーが作成されない
        expect { click_on '新規登録' }.to change { User.count }.by(0)
        # エラーメッセージが表示されること
        expect(page).to have_content 'Emailはすでに存在します'
        # 新規ユーザー登録画面にリダイレクトされる
        visit new_user_path
      end
    end
  end
end
