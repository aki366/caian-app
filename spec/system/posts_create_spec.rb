require 'rails_helper'

RSpec.describe 'Posts #create system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    context 'フォームの入力値が正常な場合' do
      it '投稿が作成できること' do
        # トップ画面にアクセス
        visit root_path
        # 新規投稿をクリック
        click_on "新規投稿"
        # 全てのフォームへ正常な値を入力
        fill_in 'post_content',     with: 'テスト投稿'
        # "投稿する"をクリックすると投稿が作成される
        expect { click_on '投稿する' }.to change { Post.count }.by(1)
        # 現在のパスが指定されたパスであることを検証する
        expect(current_path).to eq "/posts"
        # メッセージが表示される
        expect(page).to have_content '投稿を作成しました'
      end
    end
  end
end
