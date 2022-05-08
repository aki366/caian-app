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
        # expect(response).not_to be_successful
      end
    end
  end

  describe 'GET #edit' do
    let!(:user) { create(:user) }
    subject { get edit_user_path(user.id) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'ユーザーが自分の場合' do
        it 'ユーザーの編集画面に遷移できること' do
          subject
          expect(response).to be_successful
        end
        it 'ユーザー名が表示されること' do
          subject
          expect(response.body).to include user.name
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'ユーザーの編集画面に遷移できないこと' do
          # expect(response).to be_successful
        end
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザーの編集画面に遷移できないこと' do
        # expect(response).to be_successful
      end
    end
    context 'userがゲストのとき' do
      it 'ユーザーの編集画面に遷移できないこと' do
        # expect(response).to be_successful
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
        # expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) { create(:user) }
    subject { put user_path(user.id) }
    context 'userがゲストのとき' do
      it 'ユーザー情報が更新されないこと' do
      end
    end
    context 'userがゲストではないとき' do
      context 'パラメータが正常な場合' do
        it 'ユーザー情報が更新されること' do
          # expect { subject }.to change { user }
          # expect(response).to be_successful
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
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    subject { delete user_path(user.id) }
    context 'userがゲストのとき' do
      it 'ユーザーの削除ができないこと' do
      end
    end
    context 'userがゲストではないとき' do
      context 'ユーザーが自分の場合' do
        it '削除されること' do
          expect { subject }.to change(User, :count).by(-1)
          expect(response).to redirect_to(root_path)
        end
      end
      context 'ユーザーが自分ではない場合' do
        it '削除ができないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザーの削除ができないこと' do
      end
    end
  end

  describe 'POST #login' do
    let!(:user) { create :user }
    subject { post login_path }
    it 'ログイン画面に遷移できること' do
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
        # expect { subject }.not_to change { user }
        # expect(response).to be_successful
      end
    end
  end

  describe 'GET #likes' do
    it 'いいね!をした投稿の一覧が表示されること' do
    end
  end

  describe 'DELETE #logout' do
    subject { delete logout_path }
    it 'ログアウトができること' do
    end
  end
end