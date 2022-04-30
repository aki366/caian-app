require 'rails_helper'

RSpec.describe "Posts Request", type: :request do
  let(:user) { create(:user) }
  describe 'GET #index' do
    context 'ログイン状態のとき' do
      it 'リクエストが成功すること' do
      end
    end
  end

  describe 'GET #show' do
    context 'ログイン状態のとき' do
      it 'リクエストが成功すること' do
      end
    end
  end

  describe 'GET #new' do
    context 'ログイン状態のとき' do
      it 'リクエストが成功すること' do
      end
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当なとき' do
      before do
        # @post = FactoryBot.create(:post)
      end
      it '302レスポンスを返すこと' do
        # post users_url, params: { user: FactoryBot.attributes_for(:user) }
        # expect(response.status).to eq 302
      end
    end
  end

  describe 'GET #edit' do
    context 'ログイン状態のとき' do
      before 'ユーザーIDをセッションから取り出せるようにする' do
      end
      it 'リクエストが成功すること' do
        # expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されていること' do
        # get edit_user_url takashi
        # expect(response.body).to include 'Takashi'
      end
    end
  end

  describe 'GET #update' do
    context 'ログイン状態のとき' do
      it 'リクエストが成功すること' do
      end
    end
  end

  describe 'GET #destroy' do
    context 'ログイン状態のとき' do
      it 'リクエストが成功すること' do
      end
    end
  end
end
