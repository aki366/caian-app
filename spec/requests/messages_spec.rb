require 'rails_helper'

RSpec.describe "Messages Request", type: :request do

  describe 'POST #create' do
    context 'パラメータが正常なとき' do
      it 'メッセージを投稿できること' do
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしているとき' do
      context 'ユーザーが自分の場合' do
        it 'メッセージの編集画面に遷移できること' do
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'メッセージの編集画面に遷移できないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it 'メッセージの編集画面に遷移できないこと' do
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインしていないとき' do
      it 'メッセージ内容が更新されないこと' do
      end
    end
    context 'ログインしているとき' do
      context 'パラメータが正常な場合' do
        it 'メッセージ内容が更新されること' do
        end
      end
      context 'パラメータが不正な場合' do
        it 'メッセージ内容が更新されないこと' do
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているとき' do
      context 'ユーザーが自分の場合' do
        it 'メッセージの削除ができること' do
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'メッセージの削除ができないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it 'メッセージの削除ができないこと' do
      end
    end
  end
end
