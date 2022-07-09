require 'rails_helper'

RSpec.describe "GuestUserLogin Request", type: :request do

  describe 'GET #create' do
    let!(:guest_user) { create(:guest) }
    it 'ゲストユーザーのログインができること' do
      get guest_login_path, params: { user: {email: "guest@example.com", password: "password"} }
      expect(response).to redirect_to(posts_path)
    end
  end
end
