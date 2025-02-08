RSpec.describe Ticket, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:ticket) { FactoryBot.build(:ticket, user: user, subject: "テストサブジェクト", content: content) }

  describe '#create' do
    subject { ticket.valid? }

    describe '正常系' do
      context 'contentが1文字のとき' do
        let!(:content) { 'a' }

        it '投稿が成功すること' do
          is_expected.to be true
        end
      end

      context 'contentが1000文字のとき' do
        let!(:content) { 'a' * 1000 }

        it '投稿が成功すること' do
          is_expected.to be true
        end
      end
    end

    describe '異常系' do
      context 'contentがnullのとき' do
        let!(:content) { '' }

        it '投稿が失敗すること' do
          is_expected.to be false
          expect(ticket.errors[:content]).to include('を入力してください')
        end
      end

      context 'contentが1001文字のとき' do
        let!(:content) { 'a' * 1001 }

        it '投稿が失敗すること' do
          is_expected.to be false
          expect(ticket.errors[:content]).to include('は1000文字以内で入力してください')
        end
      end
    end
  end
end
