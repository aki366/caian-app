require 'rails_helper'

RSpec.describe 'Rooms Request', type: :request do

  describe 'POST #create' do
    subject { post rooms_path(user_ids: [user.id, room_user.id]) }
    let!(:user) { create(:user) }
    let(:room_user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'パラメータが正常な場合' do
        it 'トークルームが作成できること' do
          expect { subject }.to change(RoomUser, :count).by(+2)
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end

  describe 'GET #show' do
    context 'ログインしているとき' do
      context 'トークルームのユーザーが自分の場合' do
        it 'トークルーム画面に遷移できること' do
        end
      end
      context 'トークルームのユーザーが自分ではない場合' do
        it 'トークルーム画面に遷移できないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it 'トークルーム画面に遷移できないこと' do
      end
    end
  end
end
