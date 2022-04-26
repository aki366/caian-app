require 'rails_helper'

RSpec.describe 'Users Request', type: :request do
  let(:user) { create(:user) }
  describe 'GET #new' do
    context '新規ユーザー登録をするとき' do
      it '登録画面に遷移すること' do
        get new_user_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST #create' do
    describe 'パラメータが妥当なとき' do
      before do
        # post users_path
      end
      it 'リクエストが成功すること' do
        # expect(response.status).to eq 200
      end
      it 'ユーザーが登録されること' do
        # expect(user.name).to eq 'test'
      end
    end
  end
  
  describe 'GET #show' do
    context 'ログイン状態のとき' do
      before do
        allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: user.id)
        get user_path(user.id)
      end
      it 'ユーザー詳細画面に遷移すること' do
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されること' do
        expect(response.body).to include 'test'
      end
    end
  end

  describe 'GET #edit' do
    context 'ログイン状態のとき' do
      before 'ユーザーIDをセッションから取り出せるようにする' do
        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session).and_return(user_id: user.id)
        get edit_user_path(user.id)
      end
      it '編集画面に遷移すること' do
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されること' do
        expect(response.body).to include user.name
      end
    end

    context 'ゲストユーザーの場合' do
  #     before do
  #       sign_in(@guest_user)
  #       get edit_user_registration_path(@guest_user)
      # end
      it 'トップページにリダイレクトされること' do
  #       expect(response.status).to eq 302
  #       expect(response).to redirect_to root_path
      end
    end
  end


  describe 'PUT #update' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
  #       patch user_registration_path, params: { user: attributes_for(:user).merge(password: 'testtest') }
  #       expect(response.status).to eq 302
  #       expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ログイン状態でパラメータが妥当な場合' do
  #     before do
  #       sign_in(user)
  #       patch user_registration_path, params: { user: attributes_for(:user).merge(password: 'testtest') }
      # end

      it 'リクエストが成功すること' do
  #       expect(response.status).to eq 302
      end

      it 'ユーザー名が更新されること' do
  #       expect(User.name).not_to eq 'test'
      end

      it 'リダイレクトすること' do
  #       expect(response).to redirect_to user
      end
    end

    context 'ゲストユーザーのとき' do
  #     before do
  #       sign_in(@guest_user)
  #       patch user_registration_path, params: { user: attributes_for(:user).merge(password: 'testtest') }
  #     end

      it 'トップページにリダイレクトされること' do
  #       expect(response.status).to eq 302
  #       expect(response).to redirect_to root_path
      end
    end
  end
end
