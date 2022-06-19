require 'rails_helper'

RSpec.describe "Posts Request", type: :request do

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
    let!(:post) { create(:post) }
    let!(:user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      it '投稿の詳細画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
    end
    context 'ログインしていないとき' do
      it '投稿の詳細画面に遷移できないこと' do
        subject
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'GET #edit' do
    let!(:user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    let(:other_user_post) { create(:post) }
    subject { get edit_post_path(user_post.id) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'ユーザーが自分の場合' do
        it '投稿の編集画面に遷移できること' do
          subject
          expect(response).to be_successful
        end
      end
      context 'ユーザーが自分ではない場合' do
        it '投稿の編集画面に遷移できないこと' do
          other_user_id = user.id + 1
          other_user_post
          get edit_post_path(other_user_id)
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      it '投稿の編集画面に遷移できないこと' do
        subject
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'パラメータが正常な場合' do
        it '投稿内容が更新されること' do
          # byebug
          expect do
            put post_path(user_post.id), params: { post: {content: "投稿を編集しました"} }
          end.to change { Post.find(1).content }
          expect(response).to redirect_to(posts_path)
        end
      end
      context 'パラメータが不正な場合' do
        # subject { put post_path(post.id) }
        it '投稿内容が更新されないこと' do
          # expect { subject }.not_to change { Post.find(1).content }
          # expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      # subject { put post_path(post.id), params: {content: "投稿を編集しました"} }
      it '投稿内容が更新されないこと' do
        # expect { subject }.not_to change { Post.find(1).content }
        # expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete post_path(post.id) }
    context 'ログインしているとき' do
      # let!(:user) { create(:user) }
      # include_context 'login_as_user'
      # let!(:post) { create(:post) }
      context 'ユーザーが自分の場合' do
        it '投稿の削除ができること' do
          # byebug
          # expect { subject }.not_to change { post }
          # expect(response).to redirect_to(post_path)
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
