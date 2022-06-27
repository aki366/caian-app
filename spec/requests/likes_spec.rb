require 'rails_helper'

RSpec.describe "Likes Request", type: :request do

  describe 'POST #create' do
    context 'パラメータが正常なとき' do
      it 'イイね!が作成できること' do
      end
    end
    context 'パラメータが不正なとき' do
      it 'イイね!が作成できないこと' do
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているとき' do
      context 'ユーザーが自分の場合' do
        it 'イイね!の削除ができること' do
        end
      end
      context 'ユーザーが自分ではない場合' do
        it 'イイね!の削除ができないこと' do
        end
      end
    end
    context 'ログインしていないとき' do
      it 'イイね!の削除ができないこと' do
      end
    end
  end
end
