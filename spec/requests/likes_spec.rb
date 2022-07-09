require 'rails_helper'

RSpec.describe "Likes Request", type: :request do

  describe 'POST #create' do
    subject { post post_likes_path(user_post.id) }
    let!(:user_post) { create(:post) }
    let!(:user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      it 'イイね!が作成できること' do
        expect { subject }.to change(Like, :count).by(+1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'ログインしていないとき' do
      it 'イイね!が作成できないこと' do
        expect { subject }.to change(Like, :count).by(0)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete post_like_path(user_post.id, post_like.id) }
    let!(:user_post) { create(:post) }
    let!(:user) { create(:user) }
    let!(:post_like) { create(:like, post_id: user_post.id, user_id: user.id) }
    let(:other_user) {create(:user)}
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'ユーザーが自分の場合' do
        it 'イイね!の削除ができること' do
          expect { subject }.to change(Like, :count).by(-1)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'イイね!の削除ができないこと' do
          other_user
          expect { subject }.not_to change { post_like }
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      it 'イイね!の削除ができないこと' do
        expect { subject }.not_to change { post_like }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
