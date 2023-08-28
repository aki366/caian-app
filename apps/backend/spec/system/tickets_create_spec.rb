RSpec.describe 'Tickets #create system', type: :system do

  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    context 'フォームの入力値が正常な場合' do
      it '投稿が作成できること' do
        # トップ画面にアクセス
        visit root_path
        # 新規投稿をクリック
        # click_on "新規投稿"
        # 全てのフォームへ正常な値を入力
        # fill_in 'ticket_content',     with: 'テスト投稿'
        # "投稿する"をクリックすると投稿が作成される
        # expect { click_on '投稿する' }.to change { Ticket.count }.by(1)
        # 現在のパスが指定されたパスであることを検証する
        # expect(current_path).to eq "/tickets"
        # メッセージが表示される
        # expect(page).to have_content '投稿を作成しました'
      end
    end
    context '投稿内容が未入力の場合' do
      it '投稿が作成できないこと' do
        # トップ画面にアクセス
        visit root_path
        # 新規投稿をクリック
        # click_on "新規投稿"
        # 投稿フォームの値がnil
        # fill_in 'ticket_content',     with: ''
        # "投稿する"をクリックしても投稿が作成されない
        # expect { click_on '投稿する' }.to change { Ticket.count }.by(0)
        # 現在のパスが指定されたパスであることを検証する
        # expect(current_path).to eq "/tickets"
        # メッセージが表示される
        # expect(page).to have_content 'Contentを入力してください'
      end
    end
    context '投稿内容が1001文字の場合' do
      it '投稿が作成できないこと' do
        # トップ画面にアクセス
        visit root_path
        # 新規投稿をクリック
        # click_on "新規投稿"
        # 投稿フォームの値が1001文字の場合
        # fill_in 'ticket_content',     with: 'a' * 1001
        # "投稿する"をクリックしても投稿が作成されない
        # expect { click_on '投稿する' }.to change { Ticket.count }.by(0)
        # 現在のパスが指定されたパスであることを検証する
        # expect(current_path).to eq "/tickets"
        # メッセージが表示される
        # expect(page).to have_content 'Contentは1000文字以内で入力してください'
      end
    end
  end
end
