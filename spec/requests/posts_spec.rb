require 'rails_helper'

RSpec.describe "Posts Request", type: :request do
  let(:post) { create(:post) }

  describe 'GET #new' do
    subject { get new_post_path(user.id) }
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    it '新規投稿画面に遷移できること' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    # subject { post posts_path }
    context 'パラメータが正常なとき' do
      # before do
      #   @post = create(:post)
      # end
      it '新規投稿できること' do
        # subject
        # expect(response).to have_http_status(:redirect)
      end
      # it 'メッセージが表示されること' do
      #   expect(response.body).to include '投稿を作成しました'
      # end
    end
  end

  describe 'GET #index' do
    subject { get posts_path }
    context 'ログインしているとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'
      it '投稿の一覧画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
    end
    context 'ログインしていないとき' do
      it '投稿の一覧画面に遷移できないこと' do
        subject
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'GET #show' do
    subject { get post_path(post.id) }
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      it '投稿の詳細画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
    end
    context 'ログインしていないとき' do
      it '投稿の詳細画面に遷移できないこと' do
        # byebug
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしているとき' do
      before 'ユーザーIDをセッションから取り出せるようにする' do
      end
      context 'ユーザーが自分の場合' do
        it '投稿の編集画面に遷移できること' do
          # expect(response.status).to eq 200
        end
      end
      context 'ユーザーが自分ではない場合' do
        it '投稿の編集画面に遷移できないこと' do
          # get edit_user_url takashi
          # expect(response.body).to include 'Takashi'
        end
      end
    end
    context 'ログインしていないとき' do
      it '投稿の編集画面に遷移できないこと' do
        # get edit_user_url takashi
        # expect(response.body).to include 'Takashi'
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインしているとき' do
      context 'パラメータが正常な場合' do
        it '投稿内容が更新されること' do
        end
      end
      context 'パラメータが不正な場合' do
        it '投稿内容が更新されないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it '投稿内容が更新されないこと' do
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているとき' do
      context 'ユーザーが自分の場合' do
        it '投稿の削除ができること' do
        end
      end
      context 'ユーザーが自分ではない場合' do
        it '投稿の削除ができないこと' do
          # expect(response.body).to include '投稿を削除しました'
        end
      end
    end
    context 'ログインしていないとき' do
      it '投稿の削除ができないこと' do
        # expect(response.body).to include '投稿を削除しました'
      end
    end
  end
end
