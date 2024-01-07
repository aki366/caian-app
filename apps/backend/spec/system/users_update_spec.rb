RSpec.describe 'Users #update system', type: :system do
  describe 'ログインしているとき' do
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    context '名前を変更した場合' do
      it 'ユーザー情報が更新されること' do
        visit edit_user_path(user.id)
        fill_in 'name', with: 'ヤマダ'
        expect { click_on '変更' }.to change { User.last.name }
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'ユーザー情報を編集しました'
      end
    end

    context '名前が未入力の場合' do
      it 'ユーザー情報が更新されないこと' do
        visit edit_user_path(user.id)
        fill_in 'name', with: ''
        expect { click_on '変更' }.not_to change { User.last.name }
        expect(current_path).to eq "/users/#{user.id}"
        expect(page).to have_content 'Nameを入力してください'
      end
    end

    context 'メールアドレスを変更した場合' do
      it 'ユーザー情報が更新されること' do
        visit edit_user_path(user.id)
        fill_in 'email', with: 'system@example.com'
        expect { click_on '変更' }.to change { User.last.email }
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'ユーザー情報を編集しました'
      end
    end

    context 'メールアドレスが未入力の場合' do
      it 'ユーザー情報が更新されないこと' do
        visit edit_user_path(user.id)
        fill_in 'email', with: ''
        expect { click_on '変更' }.not_to change { User.last.email }
        expect(current_path).to eq "/users/#{user.id}"
        expect(page).to have_content 'Emailを入力してください'
      end
    end

    context 'パスワードを変更した場合' do
      it 'ユーザー情報が更新されること' do
        visit edit_user_path(user.id)
        fill_in 'password', with: 'password'
        expect { click_on '変更' }.to change { User.last.password_digest }
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'ユーザー情報を編集しました'
      end
    end

    context 'パスワードが未入力の場合' do
      it 'ユーザー情報が更新されること' do
        visit edit_user_path(user.id)
        fill_in 'name',     with: 'ヤマダ'
        fill_in 'password', with: ''
        expect { click_on '変更' }.to change { User.last.name }
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'ユーザー情報を編集しました'
      end
    end
  end
end
