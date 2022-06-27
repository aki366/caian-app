require 'rails_helper'

RSpec.describe "Comments Request", type: :request do

  describe 'POST #create' do
    let!(:user_post) { create(:post) }
    let!(:user) { create(:user) }
    let(:user_comment) { create(:comment, post_id: post.id) }
    include_context 'login_as_user'
    context 'パラメータが正常なとき' do
      it 'コメントが投稿できること' do
        expect do
          post post_comments_path(user_post.id), params: { comment: {comment_text: "コメントを投稿しました"} }
        end.to change(Comment, :count).by(+1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'パラメータが不正なとき' do
      it 'コメントが投稿できないこと' do
        expect do
          post post_comments_path(user_post.id), params: { comment: {comment_text: ""} }
        end.to change(Comment, :count).by(+0)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  # describe 'GET #edit' do
  #   context 'ログインしているとき' do
  #     context 'ユーザーが自分の場合' do
  #       it 'コメントの編集画面に遷移できること' do
  #       end
  #     end
  #     context 'ユーザーが自分ではない場合' do
  #       it 'コメントの編集画面に遷移できないこと' do
  #       end
  #     end
  #   end
  #   context 'ログインしていないとき' do
  #     it 'コメントの編集画面に遷移できないこと' do
  #     end
  #   end
  # end

  # describe 'GET #show' do
  #   context 'ログインしているとき' do
  #     it 'コメントの詳細画面に遷移できること' do
  #     end
  #   end
  #   context 'ログインしていないとき' do
  #     it 'コメントの詳細画面に遷移できないこと' do
  #     end
  #   end
  # end

  # describe 'PUT #update' do
  #   context 'ログインしていないとき' do
  #     it 'コメント情報が更新されないこと' do
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    context 'ログインしているとき' do
      context 'ユーザーが自分の場合' do
        it 'コメントの削除ができること' do
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'コメントの削除ができないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it 'コメントの削除ができないこと' do
      end
    end
  end
end
