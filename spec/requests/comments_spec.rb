require 'rails_helper'

RSpec.describe "Comments Request", type: :request do
  let(:user) { create(:user) }
  describe 'GET #edit' do
    context 'ログイン状態のとき' do
      before 'ユーザーIDをセッションから取り出せるようにする' do
        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session).and_return(user_id: user.id)
        get edit_user_path(user.id)
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されていること' do
        expect(response.body).to include user.name
      end
    end
  end
end
