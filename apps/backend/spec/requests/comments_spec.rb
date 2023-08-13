require 'rails_helper'

RSpec.describe "Comments Request", type: :request do

  describe 'POST #create' do
    let!(:user_ticket) { create(:ticket) }
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    context 'パラメータが正常なとき' do
      it 'コメントが投稿できること' do
        expect do
          post ticket_comments_path(user_ticket.id), params: { comment: {text: "コメントを投稿しました"} }
        end.to change(Comment, :count).by(+1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'パラメータが不正なとき' do
      it 'コメントが投稿できないこと' do
        expect do
          post ticket_comments_path(user_ticket.id), params: { comment: {text: ""} }
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
    subject { delete ticket_comment_path(user_ticket.id, ticket_comment.id) }
    # テスト条件
    # user.id(1)の投稿に対して、user.id(2)がコメントを投稿した状態
    let!(:user_ticket) { create(:ticket) }
    let!(:user) { create(:user) }
    let!(:ticket_comment) { create(:comment, ticket_id: user_ticket.id, user_id: user.id) }
    let(:other_user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'ユーザーが自分の場合' do
        it 'コメントの削除ができること' do
          expect { subject }.to change(Comment, :count).by(-1)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'コメントの削除ができないこと' do
          other_user
          expect { subject }.not_to change { ticket_comment }
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      it 'コメントの削除ができないこと' do
        expect { subject }.not_to change { ticket_comment }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
