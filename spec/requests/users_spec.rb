require 'rails_helper'

RSpec.describe 'Users Request', type: :request do
  let(:user) { create(:user) }
  describe 'GET #new' do
    context '新規ユーザー登録をしたとき' do
      it '200レスポンスを返すこと' do
        get new_user_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当なとき' do
      before do
        # spec/support/factory_bot.rbで
        # config.include FactoryBot::Syntax::Methodsと
        # 設定しているので、"FactoryBot"は省略
        @user = create(:user)
      end
      it '302レスポンスを返すこと' do
        post users_path, params: { user: attributes_for(:user) }
        expect(response.status).to eq 302
      end
      it 'ユーザーが登録されること' do
        expect do
          post users_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      it 'リダイレクトすること' do
        post users_path, params: { user: attributes_for(:user) }
        expect(response).to redirect_to User.last
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
      it '200レスポンスを返すこと' do
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
      it '200レスポンスを返すこと' do
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されること' do
        expect(response.body).to include user.name
      end
    end
  end

  describe 'PUT #update' do
    context 'ログイン状態のとき' do
      before do
      allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session).and_return(user_id: user.id)
      put user_path(user.id)
      end
      it '200レスポンスを返すこと' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    it 'ユーザーが削除されること' do
      expect do
        delete user_path(user.id)
      end.to change(User, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end
end
