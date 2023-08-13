require 'rails_helper'

RSpec.describe "Messages Request", type: :request do

  describe 'POST #create' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'パラメータが正常なとき' do
        it 'メッセージが投稿できること' do
          Room.create(user_ids: [user.id, other_user.id])
          expect do
            post room_messages_path(Room.last.id), params: { message: {text: "メッセージを投稿しました"} }
          end.to change(Message, :count).by(1)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'パラメータが不正なとき' do
        it 'メッセージが投稿できないこと' do
          Room.create(user_ids: [user.id, other_user.id])
          expect do
            post room_messages_path(Room.last.id), params: { message: {text: ""} }
          end.to change(Message, :count).by(0)
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      it 'メッセージが投稿できないこと' do
        Room.create(user_ids: [user.id, other_user.id])
        expect do
          post room_messages_path(Room.last.id), params: { message: {text: "メッセージを投稿しました"} }
        end.to change(Message, :count).by(0)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  # 編集機能を実装した際にテスト作成
  # describe 'GET #edit' do
  #   context 'ログインしているとき' do
  #     context 'ユーザーが自分の場合' do
  #       it 'メッセージの編集画面に遷移できること' do
  #       end
  #     end
  #     context 'ユーザーが自分ではない場合' do
  #       it 'メッセージの編集画面に遷移できないこと' do
  #       end
  #     end
  #   end
  #   context 'ログインしていないとき' do
  #     it 'メッセージの編集画面に遷移できないこと' do
  #     end
  #   end
  # end

  # 編集機能を実装した際にテスト作成
  # describe 'PUT #update' do
  #   context 'ログインしていないとき' do
  #     it 'メッセージ内容が更新されないこと' do
  #     end
  #   end
  #   context 'ログインしているとき' do
  #     context 'パラメータが正常な場合' do
  #       it 'メッセージ内容が更新されること' do
  #       end
  #     end
  #     context 'パラメータが不正な場合' do
  #       it 'メッセージ内容が更新されないこと' do
  #       end
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    subject { delete room_message_path(Room.first.id, Message.last.id) }
    let!(:user) { create(:user) }
    let!(:room) { create(:room, :with_users) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      before do
        post room_messages_path(Room.first.id), params: { message: {text: "メッセージを投稿しました"} }
      end
      context 'ユーザーが自分の場合' do
        it 'メッセージの削除ができること' do
          expect { subject }.to change(Message, :count).by(-1)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'メッセージの削除ができないこと' do
          other_user_id = user.id + 1
          create(:message, user_id: other_user_id, room_id: room.id)
          expect { subject }.to change(Message, :count).by(0)
          expect(response).to have_http_status(204)
        end
      end
    end
  end
end
