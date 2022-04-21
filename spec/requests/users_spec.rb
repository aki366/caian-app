require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  before do
    @guest_user = User.create(
      name: 'ゲストユーザー',
      email: 'guest@example.com',
      password: 'password'
    )
  end

  describe 'GET #show' do
    context 'ユーザーが存在するとき' do
      before do
        get posts_path
      end
      it 'リクエストが成功すること' do
        get users_path
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されていること' do
        expect(response.body).to include 'test'
      end
    end
  end

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_user_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    context 'ログイン状態のとき' do
      # before do
      #   @user = create(:user)
      #   get edit_user_path
      # end

      # it 'リクエストが成功すること' do
      #   expect(response.status).to eq 200
      # end

  #     it 'ユーザー名が表示されていること' do
  #       expect(response.body).to include 'test'
  #     end
    end

  #   context 'ゲストユーザーの場合' do
  #     before do
  #       sign_in(@guest_user)
  #       get edit_user_registration_path(@guest_user)
  #     end

  #     it 'トップページにリダイレクトされること' do
  #       expect(response.status).to eq 302
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  # end

  # describe 'POST #create' do
  #   describe 'パラメータが妥当なとき' do
  #     before do
  #       post user_registration_path
  #     end

  #     it 'リクエストが成功すること' do
  #       expect(response.status).to eq 200
  #     end

  #     it 'ユーザーが登録されること' do
  #       expect(user.name).to eq 'test'
  #     end
  #   end
  # end

  # describe 'PUT #update' do
  #   context '未ログイン状態のとき' do
  #     it 'ログインページにリダイレクトされること' do
  #       patch user_registration_path, params: { user: attributes_for(:user).merge(password: 'testtest') }
  #       expect(response.status).to eq 302
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end

  #   context 'ログイン状態でパラメータが妥当な場合' do
  #     before do
  #       sign_in(user)
  #       patch user_registration_path, params: { user: attributes_for(:user).merge(password: 'testtest') }
  #     end

  #     it 'リクエストが成功すること' do
  #       expect(response.status).to eq 302
  #     end

  #     it 'ユーザー名が更新されること' do
  #       expect(User.name).not_to eq 'test'
  #     end

  #     it 'リダイレクトすること' do
  #       expect(response).to redirect_to user
  #     end
  #   end

  #   context 'ゲストユーザーのとき' do
  #     before do
  #       sign_in(@guest_user)
  #       patch user_registration_path, params: { user: attributes_for(:user).merge(password: 'testtest') }
  #     end

  #     it 'トップページにリダイレクトされること' do
  #       expect(response.status).to eq 302
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  end
end
