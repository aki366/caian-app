require 'rails_helper'

RSpec.describe 'Users #index system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    include_context 'login_as_user'
    it 'ユーザーの一覧画面に遷移できること' do
      # # トップ画面にアクセス
      # visit root_path
      # # ヘッダーのユーザー一覧をクリック
      # click_on 'ユーザー一覧'
      # # 現在のパスが指定されたパスであることを検証する
      # expect(current_path).to eq "/users"
      # # ページ内に特定のリンクが表示されているか
      # expect(page).to have_link 'Caian'
      # expect(page).to have_link user.name
      # expect(page).to have_link 'ユーザー一覧'
      # expect(page).to have_link '投稿一覧'
      # expect(page).to have_link '新規投稿'
      # # 各ユーザーのイメージが表示されているか
      # expect(page).to have_selector("img[src$='guest_user_icon.png']")
      # # 各ユーザーの名前が表示されているか
      # expect(page).to have_content User.find(1).name
      # expect(page).to have_content User.find(2).name
      # # ページ内に特定のボタンが表示されているか
      # expect(page).to have_button 'ログアウト'
    end
  end
end
