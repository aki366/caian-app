RSpec.describe Ticket, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:ticket) { FactoryBot.build(:ticket, user: user, subject: "テストサブジェクト", content: content) }

  describe '#create' do

    describe '正常系' do
      context 'contentに英数字、大文字小文字、記号ひらがなカタカナ漢字で投稿したとき' do
        let(:content) { '@:20xX、新人育成のベストプラクティス１０' }

        it '投稿が成功すること' do
          expect(ticket).to be_valid
        end
      end

      context 'contentが1000文字のとき' do
        let(:content) { 'a' * 1000 }

        it '投稿が成功すること' do
          expect(ticket).to be_valid
        end
      end
    end

    describe '異常系' do
      context 'contentがnullのとき' do
        let!(:content) { '' }

        it '投稿が失敗すること' do
          expect(ticket).not_to be_valid
          expect(ticket.errors[:content]).to include('を入力してください')
        end
      end

      context 'contentが1001文字のとき' do
        let(:content) { 'a' * 1001 }

        it '投稿が失敗すること' do
          expect(ticket).not_to be_valid
          expect(ticket.errors[:content]).to include('は1000文字以内で入力してください')
        end
      end
    end
  end
end
