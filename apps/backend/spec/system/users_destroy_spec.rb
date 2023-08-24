require 'rails_helper'

RSpec.describe 'Users #destroy system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    context 'ユーザーが自分の場合' do
      it '削除されること' do
        # # トップ画面にアクセス
        # visit root_path
        # # ユーザーの詳細画面に遷移
        # click_on user.name
        # # 編集をクリック
        # click_on "アカウント削除"
        # # ダイアログが表示され、"OK"を選択
        # expect(page.accept_confirm).to eq "このアカウントを削除します。この操作は取り消せません。よろしいですか？"
        # # 現在のパスが指定されたパスであることを検証する
        # expect(current_path).to eq root_path
        # # ページ内に特定のリンクが表示されているか
        # expect(page).to have_link 'Caian'
        # expect(page).to have_link 'Caianとは'
        # expect(page).to have_link 'ユーザー登録'
        # expect(page).to have_link 'ログイン'
        # # メッセージが表示される
        # expect(page).to have_content 'アカウントを削除しました'
      end
    end
  end
end
