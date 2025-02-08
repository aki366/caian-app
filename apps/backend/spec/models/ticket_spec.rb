RSpec.describe Ticket, type: :model do
  let!(:ticket) { FactoryBot.build(:ticket, subject: "テストサブジェクト", content: content) }

  describe '#create' do
    subject { ticket.valid? }

    # context '投稿内容が最小の1文字のとき' do
    #   let!(:content) { 'a' }

    #   it '投稿が成功すること' do
    #     is_expected.to be true
    #   end
    # end

    context '投稿内容が空のとき' do
      let!(:content) { '' }

      it '投稿が失敗すること' do
        is_expected.to be false
        expect(ticket.errors[:content]).to include('を入力してください')
      end
    end

    # context '投稿内容が最大の1000文字のとき' do
    #   let!(:content) { 'a' * 1000 }

    #   it '投稿が成功すること' do
    #     is_expected.to be true
    #   end
    # end

    context '投稿内容が1001文字のとき（上限を超える）' do
      let!(:content) { 'a' * 1001 }

      it '投稿が失敗すること' do
        is_expected.to be false
        expect(ticket.errors[:content]).to include('は1000文字以内で入力してください')
      end
    end
  end
end
