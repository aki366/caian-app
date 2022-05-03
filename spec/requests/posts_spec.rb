require 'rails_helper'

RSpec.describe "Posts Request", type: :request do
  let(:post) { create(:post) }
  describe 'GET #new' do
    context '新規投稿をするとき' do
      it '302レスポンスを返すこと' do
        get new_post_path
        expect(response.status).to eq 302
      end
    end
  end
  
  describe 'POST #create' do
    context '新規投稿をしたとき' do
      before do
        @post = FactoryBot.create(:post)
        post posts_path
      end
      it '302レスポンスを返すこと' do
        # post posts_url, params: { post: FactoryBot.attributes_for(:post) }
        # post posts_url
        expect(response.status).to eq 302
      end
      it 'メッセージが表示されること' do
        expect(response.body).to include '投稿を作成しました'
      end
    end
  end

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

  describe 'PUT #update' do
    context 'ログイン状態のとき' do
      it 'リクエストが成功すること' do
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログイン状態のとき' do
      it 'リクエストが成功すること' do
      end
      it 'メッセージが表示されること' do
        # expect(response.body).to include '投稿を削除しました'
      end
    end
  end
end
