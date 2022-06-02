require 'rails_helper'

RSpec.describe 'Users Request', type: :request do
  let(:user) { create(:user) }

  describe 'GET #new' do
    subject { get new_user_path }
    it 'ユーザーの新規作成画面に遷移できること' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    subject { post users_path }
    context 'パラメータが正常なとき' do
      before do
        # spec/support/factory_bot.rbで
        # config.include FactoryBot::Syntax::Methodsと
        # 設定しているので、"FactoryBot"は省略
        @user = create(:user)
      end
      it 'ユーザーが作成できること' do
        expect do
          post users_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(+1)
        expect(response).to redirect_to User.last
      end
    end
    context 'パラメータが不正なとき' do
      it 'ユーザーが作成できないこと' do
        test
        # expect
      end
    end
  end

  describe 'GET #index' do
    subject { get users_path }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      it 'ユーザーの一覧画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
      it 'ユーザー一覧が取得できること' do
        subject
        expect(response.body).to include 'test'
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザーの一覧画面に遷移できないこと' do
        subject
        expect(response).not_to be_successful
      end
    end
  end

  describe 'GET #edit' do
    subject { get edit_user_path(user.id) }
    context 'ログインしているとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'
      context 'ユーザーが自分の場合' do
        it 'ユーザーの編集画面に遷移できること' do
          subject
          expect(response).to be_successful
        end
        # it 'ユーザー名が表示されること' do
        # リクエストのテストでは無いか
        #   subject
        #   expect(response.body).to include user.name
        # end
      end
      context 'ユーザーが自分ではない場合' do
        it 'ユーザーの編集画面に遷移できないこと' do
          other_user_id = user.id + 1
          get edit_user_path(other_user_id)
          expect(response).to redirect_to(posts_path)
        end
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザーの編集画面に遷移できないこと' do
        subject
        expect(response).to redirect_to(new_login_path)
      end
    end
    context 'ユーザーがゲストのとき' do
      let!(:user) { create(:guest) }
      include_context 'login_as_user'
      it 'ユーザーの編集画面に遷移できないこと' do
        expect { subject }.not_to change { user }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #show' do
    subject { get user_path(user.id) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      it 'ユーザーの詳細ページに遷移できること' do
        subject
        expect(response).to be_successful
      end
      it 'ユーザー名が表示されること' do
        subject
        expect(response.body).to include 'test'
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザーの詳細ページに遷移できないこと' do
        subject
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'PUT #update' do
    # パラメーターを追加
    subject { put user_path(user.id), params: { career: "hacker"} }
    context 'ユーザーがゲストのとき' do
      let!(:user) { create(:guest) }
      include_context 'login_as_user'
      it 'ユーザー情報が更新されないこと' do
        expect { subject }.not_to change { user }
        # 不正な場合はリダイレクトされる
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'ユーザーがゲストではないとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'
      context 'パラメータが正常な場合' do
        it 'ユーザー情報が更新されること' do
          # test
          expect { subject }.to change { user }
          expect(response).to be_successful
        end
      end
      context 'パラメータが不正な場合' do
        include_context 'login_as_user'
        it 'ユーザー情報が更新されないこと' do
          expect { subject }.not_to change { user }
          expect(response).to be_successful
        end
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザー情報が更新されないこと' do
        expect { subject }.not_to change { user }
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete user_path(user.id) }
    context 'ユーザーがゲストのとき' do
      let!(:user) { create(:guest) }
      include_context 'login_as_user'
      it 'ユーザーの削除ができないこと' do
        expect { subject }.not_to change { user }
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'ユーザーがゲストではないとき' do
      let!(:user) { create :user }
      context 'ユーザーが自分の場合' do
        it '削除されること' do
          expect { subject }.to change(User, :count).by(-1)
          expect(response).to redirect_to(root_path)
        end
      end
      context 'ユーザーが自分ではない場合' do
        it '削除ができないこと' do
          test
        end
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザーの削除ができないこと' do
        test
      end
    end
  end

  describe 'POST #login' do
    let!(:user) { create :user }
    subject { post login_path }
    it 'ログイン画面に遷移できること' do
      test
      # subject
      # expect(response).to be_successful
    end
  end

  describe 'GET #login_form' do
    let!(:user) { create(:user) }
    subject { get login_path }
    context 'パラメータが正常なとき' do
      it 'ユーザーのログインができること' do
      end
    end
    context 'パラメータが不正なとき' do
      include_context 'login_as_user'
      it 'ユーザーのログインができないこと' do
        test
        # expect { subject }.not_to change { user }
        # expect(response).to be_successful
      end
    end
  end

  describe 'GET #likes' do
    it 'いいね!をした投稿の一覧が表示されること' do
      test
    end
  end

  describe 'DELETE #logout' do
    subject { delete logout_path }
    it 'ログアウトができること' do
      test
    end
  end
end
