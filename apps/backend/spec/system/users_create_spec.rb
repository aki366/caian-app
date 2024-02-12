RSpec.describe 'Users #create system', type: :system do
  describe 'ユーザーの新規登録をするとき' do
    before { visit new_user_path }

    def fill_in_form
      fill_in 'user_name',     with: user_name
      fill_in 'user_email',    with: user_email
      fill_in 'user_password', with: user_password
    end

    describe '正常系' do
      context '全ての項目を入力した場合' do
        let!(:user_name) { 'ヤマダ' }
        let!(:user_email) { 'system@example.com' }
        let!(:user_password) { 'password' }

        specify 'ユーザーが作成できること' do
          fill_in_form

          expect { click_on '新規登録' }.to change { User.count }.by(1)
          expect(current_path).to eq user_path(User.last.id)
          expect(page).to have_content 'ユーザー登録が完了しました'
        end
      end

      context 'ユーザーイメージを添付した場合' do
        specify 'アップロードできること' do
          # ユーザーが添付ファイルをアップロードする
        end
      end
    end

    describe '異常系' do
      describe '#name' do
        let!(:user_email) { 'system@example.com' }
        let!(:user_password) { 'password' }

        context '名前が未入力の場合' do
          let!(:user_name) { '' }

          specify 'ユーザーが作成できないこと' do
            fill_in_form

            expect { click_on '新規登録' }.to change { User.count }.by(0)
            expect(current_path).to eq "/users"
            expect(page).to have_content 'Nameを入力してください'
          end
        end

        context '名前が31文字以上の場合' do
          let!(:user_name) { 'a' * 31 }

          specify 'ユーザーが作成できないこと' do
            fill_in_form

            expect { click_on '新規登録' }.to change { User.count }.by(0)
            expect(current_path).to eq "/users"
            expect(page).to have_content 'Nameは30文字以内で入力してください'
          end
        end
      end

      describe '#email' do
        let!(:user_name) { 'ヤマダ' }
        let!(:user_password) { 'password' }

        context 'メールアドレスが未入力の場合' do
          let!(:user_email) { '' }

          specify 'ユーザーが作成できないこと' do
            fill_in_form

            expect { click_on '新規登録' }.to change { User.count }.by(0)
            expect(current_path).to eq "/users"
            expect(page).to have_content 'Emailを入力してください'
          end
        end

        context '登録済のメールアドレスを使用した場合' do
          let!(:user) { create(:user) }
          let!(:user_email) { user.email }
          specify 'ユーザーが作成できないこと' do
            fill_in_form

            expect { click_on '新規登録' }.to change { User.count }.by(0)
            expect(current_path).to eq "/users"
            expect(page).to have_content 'Emailはすでに存在します'
          end
        end
      end

      describe '#password' do
        let!(:user_name) { 'ヤマダ' }
        let!(:user_email) { 'system@example.co' }

        context 'パスワードが未入力の場合' do
          let!(:user_password) { '' }

          specify 'ユーザーが作成できないこと' do
            fill_in_form

            expect { click_on '新規登録' }.to change { User.count }.by(0)
            expect(current_path).to eq "/users"
            expect(page).to have_content 'Passwordを入力してください'
          end
        end
      end
    end
  end
end
