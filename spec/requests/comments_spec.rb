require 'rails_helper'

RSpec.describe "Comments Request", type: :request do

  describe 'POST #create' do
    let!(:user_post) { create(:post) }
    let!(:user) { create(:user) }
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
    subject { delete "/posts/#{user_post.id}/comments/#{post_comment.id}" }
    let!(:user_post) { create(:post) }
    let!(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:post_comment) { create(:comment, post_id: user_post.id, user_id: user.id) }
    include_context 'login_as_user'
    context 'ログインしているとき' do
      context 'ユーザーが自分の場合' do
        it 'コメントの削除ができること' do
          post_comment
          expect { subject }.to change(Comment, :count).by(-1)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'コメントの削除ができないこと' do
          post_comment
          other_user
          expect { subject }.not_to change { post_comment }
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      it 'コメントの削除ができないこと' do
        # byebug
      end
    end
  end
end
