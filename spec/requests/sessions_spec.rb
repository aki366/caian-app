require 'rails_helper'

RSpec.describe 'Sessions Request', type: :request do

  describe 'get #new' do
    subject { get new_login_path }
    context 'ログインしているとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'
      it 'ログイン画面に遷移でないこと' do
        subject
        expect(response).to redirect_to(posts_path)
      end
    end
    # ApplicationControllerのテストだが
    # 保守性を考慮してSessionsで記述
    context 'ログインしていないとき' do
      it 'ログイン画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    subject { post login_index_path }
    let!(:user) { create(:user) }
    context 'パラメータが正常なとき' do
      include_context 'login_as_user'
      it 'ユーザーのログインができること' do
        subject
        expect(response).to redirect_to(posts_path)
      end
    end
    context 'パラメータが不正なとき' do
      it 'ユーザーのログインができないこと' do
        # expect(user.authenticate("invalid_password")).to eq(false)
        # byebug
        # subject
        # expect(response).to redirect_to(new_login_path)
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
