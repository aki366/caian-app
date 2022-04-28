require 'rails_helper'

RSpec.describe 'Users Request', type: :request do
  let(:user) { create(:user) }
  describe 'GET #new' do
    context '新規ユーザー登録をするとき' do
      it '200レスポンスを返すこと' do
        get new_user_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当なとき' do
      before do
        # post user_registration_path
        # post users_path(user.id)
      end
      it '200レスポンスを返すこと' do
        # expect(response.status).to eq 200
      end
      it 'ユーザーが登録されること' do
        # expect(user.name).to eq 'test'
      end
      it 'メッセージが表示されること' do
        # expect(flash[:notice]).to eq 'ユーザー登録が完了しました'
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
end
