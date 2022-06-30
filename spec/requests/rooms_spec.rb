require 'rails_helper'

RSpec.describe 'Rooms Request', type: :request do

  describe 'POST #create' do
    context 'パラメータが正常なとき' do
      it 'トークルームを作成できること' do
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
