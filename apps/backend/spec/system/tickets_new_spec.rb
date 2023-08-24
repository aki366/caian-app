require 'rails_helper'

RSpec.describe 'Tickets #new system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    it '新規投稿画面に遷移できること' do
      # # トップ画面にアクセス
      # visit root_path
      # # 新規投稿をクリック
      # click_on "新規投稿"
      # # 現在のパスが指定されたパスであることを検証する
      # expect(current_path).to eq "/tickets/new"
      # # ページ内に特定のリンクが表示されているか
      # expect(page).to have_link 'Caian'
      # expect(page).to have_link user.name
      # expect(page).to have_link 'ユーザー一覧'
      # expect(page).to have_link '投稿一覧'
      # expect(page).to have_link '新規投稿'
      # # 入力欄のラベルが表示されているか
      # expect(page).to have_content '新規投稿'
      # # ページ内に特定のボタンが表示されているか
      # expect(page).to have_button '投稿する'
      # expect(page).to have_button 'ログアウト'
    end
  end
end
