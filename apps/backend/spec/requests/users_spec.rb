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
    context 'パラメータが正常なとき' do
      it 'ユーザーが作成できること' do
        expect do
          # paramsをハッシュ化するattributes_forを使用
          post users_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(+1)
        expect(response).to have_http_status(:redirect)
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
      # system_specの内容か
      # it 'ユーザー一覧が取得できること' do
      #   subject
      #   expect(response.body).to include 'test'
      # end
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
        # system_specの内容か
        # it 'ユーザー名が表示されること' do
        #   subject
        #   expect(response.body).to include user.name
        # end
      end

      context 'ユーザーが自分ではない場合' do
        it 'ユーザーの編集画面に遷移できないこと' do
          other_user_id = user.id + 1
          get edit_user_path(other_user_id)
          expect(response).to redirect_to(tickets_path)
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
    end

    context 'ログインしていないとき' do
      it 'ユーザーの詳細ページに遷移できないこと' do
        subject
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインしているとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'

      context 'パラメータが正常な場合' do
        subject { put user_path(user.id), params: {name: "hacker"} }

        it 'ユーザー情報が更新されること' do
          expect { subject }.to change { User.find(1).name }
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'パラメータが不正な場合' do
        subject { put user_path(user.id) }

        it 'ユーザー情報が更新されないこと' do
          expect { subject }.not_to change { User.find(1).name }
          expect(response).to have_http_status(:redirect)
        end
      end
    end

    context 'ログインしていないとき' do
      subject { put user_path(user.id), params: {name: "hacker"} }

      it 'ユーザー情報が更新されないこと' do
        expect { subject }.not_to change { user }
        expect(response).to redirect_to(new_login_path)
      end
    end

    context 'ユーザーがゲストのとき' do
      let!(:user) { create(:guest) }
      include_context 'login_as_user'

      it 'ユーザー情報が更新されないこと' do
        expect { subject }.not_to change { user }
        expect(response).to have_http_status(:redirect)
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

    context 'ログインしているとき' do
      let!(:user) { create :user }
      include_context 'login_as_user'

      context 'ユーザーが自分の場合' do
        it '削除されること' do
          expect { subject }.to change(User, :count).by(-1)
          expect(response).to redirect_to(root_path)
        end
      end

      context 'ユーザーが自分ではない場合' do
        it '削除ができないこと' do
          other_user = create(:user)
          delete user_path(other_user)
          expect(response).to have_http_status(:redirect)
        end
      end
    end

    context 'ログインしていないとき' do
      let!(:user) { create :user }

      it 'ユーザーの削除ができないこと' do
        expect { subject }.not_to change { user }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET #likes' do
    subject { get likes_user_path(user.id) }
    include_context 'login_as_user'

    it 'いいね!をした投稿の一覧が表示されること' do
      subject
      expect(response).to be_successful
    end
  end
end
