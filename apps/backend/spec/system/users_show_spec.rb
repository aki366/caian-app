require 'rails_helper'

RSpec.describe 'Users #show system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    include_context 'login_as_user'
    context 'ユーザーが自分の場合' do
      it 'ユーザーの詳細画面に遷移できること' do
        # # トップ画面にアクセス
        # visit root_path
        # # ヘッダーのユーザー名をクリック
        # click_on user.name
        # # 現在のパスが指定されたパスであることを検証する
        # expect(current_path).to eq "/users/#{user.id}"
        # # ページ内に特定のリンクが表示されているか
        # expect(page).to have_link 'Caian'
        # expect(page).to have_link user.name
        # expect(page).to have_link 'ユーザー一覧'
        # expect(page).to have_link '投稿一覧'
        # expect(page).to have_link '新規投稿'
        # expect(page).to have_link '編集'
        # expect(page).to have_link 'アカウント削除'
        # expect(page).to have_link '投稿'
        # expect(page).to have_link 'いいね!'
        # # ユーザーイメージが表示されているか
        # expect(page).to have_selector("img[src$='guest_user_icon.png']")
        # # ユーザー情報が表示されているか
        # expect(page).to have_content user.name
        # expect(page).to have_content user.email
        # # ページ内に特定のボタンが表示されているか
        # expect(page).to have_button 'ログアウト'
      end
    end
    context 'ユーザーが自分ではない場合' do
      it 'ユーザーの詳細画面に遷移できること' do
        # # トップ画面にアクセス
        # visit root_path
        # # ヘッダーのユーザー一覧をクリック
        # click_on 'ユーザー一覧'
        # # 自分ではないユーザー名をクリック
        # click_on other_user.name
        # # 現在のパスが指定されたパスであることを検証する
        # expect(current_path).to eq "/users/#{other_user.id}"
        # # ページ内に特定のリンクが表示されているか
        # expect(page).to have_link 'Caian'
        # expect(page).to have_link user.name
        # expect(page).to have_link 'ユーザー一覧'
        # expect(page).to have_link '投稿一覧'
        # expect(page).to have_link '新規投稿'
        # expect(page).not_to have_link '編集'
        # expect(page).not_to have_link 'アカウント削除'
        # expect(page).to have_link '投稿'
        # expect(page).to have_link 'いいね!'
        # # ユーザーイメージが表示されているか
        # expect(page).to have_selector("img[src$='guest_user_icon.png']")
        # # ユーザー情報が表示されているか
        # expect(page).to have_content other_user.name
        # expect(page).to have_content other_user.email
        # # ページ内に特定のボタンが表示されているか
        # expect(page).to have_button 'ログアウト'
      end
    end
  end
end
