require 'rails_helper'

RSpec.describe 'Users #edit system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    context 'ユーザーが自分の場合' do
      it 'ユーザーの編集画面に遷移できること' do
        # # トップ画面にアクセス
        # visit root_path
        # # ユーザーの詳細画面に遷移
        # click_on user.name
        # # 編集をクリック
        # click_on "編集"
        # # 現在のパスが指定されたパスであることを検証する
        # expect(current_path).to eq "/users/#{user.id}/edit"
        # # ページ内に特定のリンクが表示されているか
        # expect(page).to have_link 'Caian'
        # expect(page).to have_link user.name
        # expect(page).to have_link 'ユーザー一覧'
        # expect(page).to have_link '投稿一覧'
        # expect(page).to have_link '新規投稿'
        # # 入力欄のラベルが表示されているか
        # expect(page).to have_content 'ユーザー名'
        # expect(page).to have_content 'メールアドレス'
        # expect(page).to have_content 'パスワード'
        # expect(page).to have_content 'ユーザーイメージ'
        # # ページ内に特定のボタンが表示されているか
        # expect(page).to have_button '変更'
        # expect(page).to have_button 'ログアウト'
      end
    end
  end
end
