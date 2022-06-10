require 'rails_helper'

RSpec.describe 'Users Request', type: :request do
  let(:user) { create(:user) }

  describe 'get #login' do
    subject { get new_login_path }
    it 'ログイン画面に遷移できること' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'GET #login_form' do
    let!(:user) { create(:user) }
    subject { get login_path }
    context 'パラメータが正常なとき' do
      it 'ユーザーのログインができること' do
        test
      end
    end
    context 'パラメータが不正なとき' do
      include_context 'login_as_user'
      it 'ユーザーのログインができないこと' do
        test
        # expect { subject }.not_to change { user }
        # expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #logout' do
    subject { delete logout_path }
    it 'ログアウトができること' do
      test
    end
  end
end
