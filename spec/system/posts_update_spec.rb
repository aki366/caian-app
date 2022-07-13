require 'rails_helper'

RSpec.describe 'Posts #update system', type: :system do

  describe 'ログインしているとき' do
    let(:user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    include_context 'login_as_user'
    context 'パラメータが正常な場合' do
      it '投稿内容が更新されること' do
        # トップ画面にアクセス
        visit root_path
        # 投稿一覧ボタンをクリック
        click_on '投稿一覧'
        # 投稿一覧の投稿内容をクリック
        click_on 'Postのテスト投稿'
        # 編集をクリック
        click_on '編集'
        # 全てのフォームへ正常な値を入力
        fill_in 'post_content',     with: '投稿内容の編集'
        # "保存"をクリックすると投稿が編集される
        expect { click_on '保存' }.to change { Post.last.content }
        # 現在のパスが指定されたパスであることを検証する
        expect(current_path).to eq "/posts/#{Post.last.id}"
      end
    end
    context '投稿内容がない場合' do
      it '投稿内容が更新されないこと' do
        # トップ画面にアクセス
        visit root_path
        # 投稿一覧ボタンをクリック
        click_on '投稿一覧'
        # 投稿一覧の投稿内容をクリック
        click_on 'Postのテスト投稿'
        # 編集をクリック
        click_on '編集'
        # 投稿内容がnil
        fill_in 'post_content',     with: ''
        # "保存"をクリックすると投稿が編集される
        expect { click_on '保存' }.not_to change { Post.last.content }
        # 現在のパスが指定されたパスであることを検証する
        expect(current_path).to eq "/posts/#{Post.last.id}"
        # エラーメッセージが表示されること
        expect(page).to have_content 'Contentを入力してください'
      end
    end
    context '投稿内容が1001文字の場合' do
      it '投稿内容が更新されないこと' do
      end
    end
  end
end
