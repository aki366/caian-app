require 'rails_helper'

RSpec.describe 'Posts #show system', type: :system do

  describe 'ログインしているとき' do
    let(:user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    let!(:other_post) { create(:post, content: "その他のユーザーとして投稿") }
    include_context 'login_as_user'
    it '投稿の一覧画面に遷移できること' do
      # トップ画面にアクセス
      visit root_path
      # 投稿一覧ボタンをクリック
      click_on '投稿一覧'
      # 投稿一覧の投稿内容をクリック
      click_on 'Postのテスト投稿'
      # 現在のパスが指定されたパスであることを検証する
      expect(current_path).to eq "/posts/#{Post.find(1).id}"
      # ページ内に特定のリンクが表示されているか
      expect(page).to have_link 'Caian'
      expect(page).to have_link user.name
      expect(page).to have_link 'ユーザー一覧'
      expect(page).to have_link '投稿一覧'
      expect(page).to have_link '新規投稿'
      # ユーザーのイメージが表示されているか
      expect(page).to have_selector("img[src$='guest_user_icon.png']")
      # ユーザーの名前が表示されているか
      expect(page).to have_content Post.find(1).user.name
      # 投稿内容が表示されているか
      expect(page).to have_content Post.find(1).content
      # 投稿日時が表示されているか
      expect(page).to have_content Post.find(1).created_at
      # 更新日時が表示されているか
      expect(page).to have_content Post.find(1).updated_at
      # ページ内に特定のボタンが表示されているか
      expect(page).to have_button 'ログアウト'
    end
    context '自分の投稿の場合' do
      it '編集、削除ボタンが表示されていること' do
        # トップ画面にアクセス
        visit root_path
        # 投稿一覧ボタンをクリック
        click_on '投稿一覧'
        # 投稿一覧の投稿内容をクリック
        click_on 'Postのテスト投稿'
        # ページ内に特定のリンクが表示されているか
        expect(page).to have_link '編集'
        # ページ内に特定のボタンが表示されているか
        expect(page).to have_button '削除'
      end
    end
    context '自分の投稿ではない場合' do
      it '編集、削除ボタンが表示されていないこと' do
      end
    end
  end
end
