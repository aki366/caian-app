require 'rails_helper'

RSpec.describe "Comments Request", type: :request do

  describe 'POST #create' do
    context 'パラメータが正常なとき' do
      it 'コメントが作成できること' do
      end
    end
    context 'パラメータが不正なとき' do
      it 'コメントが作成できないこと' do
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしているとき' do
      context 'ユーザーが自分の場合' do
        it 'コメントの編集画面に遷移できること' do
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'コメントの編集画面に遷移できないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it 'コメントの編集画面に遷移できないこと' do
      end
    end

    #   before 'ユーザーIDをセッションから取り出せるようにする' do
    #     allow_any_instance_of(ActionDispatch::Request)
    #       .to receive(:session).and_return(user_id: user.id)
    #     get edit_user_path(user.id)
    #   end
    #   it 'リクエストが成功すること' do
    #     expect(response.status).to eq 200
    #   end
    #   it 'ユーザー名が表示されていること' do
    #     expect(response.body).to include user.name
    #   end
    # end
  end

  describe 'GET #show' do
    context 'ログインしているとき' do
      it 'コメントの詳細画面に遷移できること' do
      end
    end
    context 'ログインしていないとき' do
      it 'コメントの詳細画面に遷移できないこと' do
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインしていないとき' do
      it 'コメント情報が更新されないこと' do
      end
    end
  end

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
