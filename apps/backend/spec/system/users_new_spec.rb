require 'rails_helper'

RSpec.describe 'Users #new system', type: :system do

  describe 'ユーザーの新規登録をするとき' do
    it 'ユーザーの新規作成画面に遷移できること' do
      # # トップ画面にアクセス
      # visit root_path
      # # ユーザー登録ボタンをクリック
      # click_on 'ユーザー登録'
      # # 現在のパスが指定されたパスであることを検証する
      # expect(current_path).to eq "/users/new"
      # # ページ内に特定のリンクが表示されているか
      # expect(page).to have_link 'Caian'
      # expect(page).to have_link 'Caianとは'
      # expect(page).to have_link 'ユーザー登録'
      # expect(page).to have_link 'ログイン'
      # # 入力欄のラベルが表示されているか
      # expect(page).to have_content 'ユーザー名'
      # expect(page).to have_content 'メールアドレス'
      # expect(page).to have_content 'パスワード'
      # expect(page).to have_content 'ユーザーイメージ'
      # # ページ内に特定のボタンが表示されているか
      # expect(page).to have_button '新規登録'
    end
  end
end
