require 'rails_helper'

RSpec.describe 'Rooms Request', type: :request do

  describe 'POST #create' do
    subject { post rooms_path(user_ids: [user.id, room_user.id]) }
    let!(:user) { create(:user) }
    let(:room_user) { create(:user) }
    # let(:other_user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'パラメータが正常な場合' do
        it 'トークルームが作成できること' do
          expect { subject }.to change(RoomUser, :count).by(+2)
          expect(response).to have_http_status(:redirect)
        end
      end
      # viewで不正な値が入らない処理はしているが
      # コントローラー側で不正な処理を防止する場合のテスト
      # context 'パラメータが不正な場合' do
      #   it 'トークルームが作成できないこと' do
      #     byebug
      #     expect do
      #       post rooms_path(user_ids: [other_user.id, room_user.id])
      #     end.to change(RoomUser, :count).by(+0)
      #     expect(response).to have_http_status(:redirect)
      #   end
      # end
    end
    context 'ログインしていないとき' do
      it 'トークルームが作成できないこと' do
        expect { subject }.to change(RoomUser, :count).by(+0)
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'GET #show' do
    subject { get room_path(Room.find(1)) }
    let!(:user) { create(:user) }
    let(:room_user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'トークルームのユーザーが自分の場合' do
        it 'トークルーム画面に遷移できること' do
          post rooms_path(user_ids: [user.id, room_user.id])
          subject
          expect(response).to be_successful
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
