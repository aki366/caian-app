require 'rails_helper'

RSpec.describe 'Sessions Request', type: :request do

  describe 'GET #new' do
    subject { get new_login_path }

    context 'ログインしているとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'
      it 'ログイン画面に遷移でないこと' do
        subject
        expect(response).to redirect_to(tickets_path)
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'パラメータが正常なとき' do
      it 'ユーザーのログインができること' do
        post login_index_path, params: { user: {email: user.email, password: user.password} }
        expect(response).to redirect_to(tickets_path)
      end
    end

    context 'パラメータが正常なとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'

      it '既にログイン済みの場合' do
        post login_index_path, params: { user: {email: user.email, password: user.password} }
        expect(flash[:notice]).to eq("すでにログインしています")
      end
    end

    context 'パラメータが不正なとき' do
      it 'ユーザーのログインができないこと' do
        post login_index_path, params: { user: {email: user.email, password: "invalid_password"} }
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete logout_path(user.id) }
    let!(:user) { create(:user) }
    include_context 'login_as_user'

    it 'ログアウトができること' do
      subject
      expect(response).to redirect_to(new_login_path)
    end
  end
end
