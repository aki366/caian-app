RSpec.describe 'Home Request', type: :request do
  describe 'GET #top' do
    subject { get top_path }
    it 'トップ画面に遷移できること' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'GET #about' do
    subject { get about_path }
    it 'アバウト画面に遷移できること' do
      subject
      expect(response).to be_successful
    end
  end
end
