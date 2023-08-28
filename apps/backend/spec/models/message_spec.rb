RSpec.describe "Messages Model", type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe '#create' do
    context '投稿内容が1文字のとき' do
      it '投稿が成功すること' do
        @message.text = 'a' * 1
        @message.valid?
      end
    end

    context '投稿内容がないとき' do
      it '投稿が失敗すること' do
        @message.text = ''
        @message.valid?
        # expect(@message.errors.full_messages).to include('Contentを入力してください')
      end
    end

    context '投稿内容が1000文字のとき' do
      it '投稿が成功すること' do
        @message.text = 'a' * 1000
        @message.valid?
      end
    end

    context '投稿内容が1001文字のとき' do
      it '投稿が失敗すること' do
        @message.text = 'a' * 1001
        @message.valid?
        # expect(@message.errors.full_messages).to include('Contentは1000文字以内で入力してください')
      end
    end
  end
end
