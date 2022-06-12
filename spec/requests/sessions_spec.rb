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

  describe 'GET #create' do
    # subject { get new_login_path(user.id),
    #   params: {name: "ログインテスト用ユーザー", email: "login.test@example.com"} }
    context 'パラメータが正常なとき' do
      # let!(:user) { create(:login_test_user) }
      it 'ユーザーのログインができること' do
      # byebug
      # subject
      # expect(response).to have_http_status(posts_path)
      end
    end
    context 'パラメータが不正なとき' do
      it 'ユーザーのログインができないこと' do
        # https://qiita.com/nabenomoto/items/6c6a21e0d35d3f040821
        # expect(user.authenticate("password")).to be_truthy

        # expect { subject }.to change { User.find(1).name }
        # expect(response).to have_http_status(new_login_path)
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
