require 'rails_helper'

RSpec.describe 'Posts #edit system', type: :system do

  describe 'ログインしているとき' do
    let(:user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    include_context 'login_as_user'
    context 'ユーザーが自分の場合' do
      it '投稿の編集画面に遷移できること' do
        # トップ画面にアクセス
        visit root_path
        # 投稿一覧ボタンをクリック
        click_on '投稿一覧'
        # 投稿一覧の投稿内容をクリック
        click_on 'Postのテスト投稿'
        # 編集をクリック
        click_on '編集'
        # 現在のパスが指定されたパスであることを検証する
        expect(current_path).to eq "/posts/#{Post.find(1).id}/edit"
        # ページ内に特定のリンクが表示されているか
        expect(page).to have_link 'Caian'
        expect(page).to have_link user.name
        expect(page).to have_link 'ユーザー一覧'
        expect(page).to have_link '投稿一覧'
        expect(page).to have_link '新規投稿'
        # 入力欄のラベルが表示されているか
        expect(page).to have_content '投稿の編集'
        # 投稿内容が表示されているか
        expect(page).to have_content Post.find(1).content
        # ページ内に特定のボタンが表示されているか
        expect(page).to have_button 'commit'
        expect(page).to have_button 'ログアウト'
      end
    end
  end
end
