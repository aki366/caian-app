require 'rails_helper'

RSpec.describe 'Users #update system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    context '名前を変更した場合' do
      it 'ユーザー情報が更新されること' do
        # ユーザー情報の編集画面にアクセス
        visit edit_user_path(user.id)
        # フォームへ正常な値を入力
        fill_in 'name',     with: 'system_山田'
        # 変更ボタンをクリックするとユーザー情報が編集される
        expect { click_on '変更' }.to change { User.last.name }
        # ユーザー詳細画面へ遷移する
        expect(user_path(user.id)).to eq user_path(user.id)
        # メッセージが表示される
        expect(page).to have_content 'ユーザー情報を編集しました'
      end
    end
    context 'メールアドレスを変更した場合' do
      it 'ユーザー情報が更新されること' do
        # ユーザー情報の編集画面にアクセス
        visit edit_user_path(user.id)
        # フォームへ正常な値を入力
        fill_in 'email',     with: 'system@example.com'
        # 変更ボタンをクリックするとユーザー情報が編集される
        expect { click_on '変更' }.to change { User.last.email }
        # ユーザー詳細画面へ遷移する
        expect(user_path(user.id)).to eq user_path(user.id)
        # メッセージが表示される
        expect(page).to have_content 'ユーザー情報を編集しました'
      end
    end
  end
end
