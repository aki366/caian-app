require 'rails_helper'

RSpec.describe 'Posts #index system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    let!(:other_post) { create(:post) }
    include_context 'login_as_user'
    it '投稿の一覧画面に遷移できること' do
      # トップ画面にアクセス
      visit root_path
      # 投稿一覧ボタンをクリック
      click_on '投稿一覧'
      # 現在のパスが指定されたパスであることを検証する
      expect(current_path).to eq "/posts"
      # ページ内に特定のリンクが表示されているか
      expect(page).to have_link 'Caian'
      expect(page).to have_link user.name
      expect(page).to have_link 'ユーザー一覧'
      expect(page).to have_link '投稿一覧'
      expect(page).to have_link '新規投稿'
      # 各ユーザーのイメージが表示されているか
      expect(page).to have_selector("img[src$='guest_user_icon.png']")
      # 各ユーザーの名前が表示されているか
      expect(page).to have_content Post.find(1).user.name
      expect(page).to have_content Post.find(2).user.name
      # 各ユーザーの投稿が表示されているか
      expect(page).to have_content Post.find(1).content
      expect(page).to have_content Post.find(2).content
      # ページ内に特定のボタンが表示されているか
      expect(page).to have_button 'ログアウト'
    end
  end
end
