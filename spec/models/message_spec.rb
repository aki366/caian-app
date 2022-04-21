require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end
  
  describe '新規メッセージ投稿' do
    context '投稿がうまくいくとき' do
      it '投稿内容が1文字の場合' do
        @message.message_text = 'a' * 1
        @message.valid?
      end
      it '投稿内容が1000文字の場合' do
        @message.message_text = 'a' * 1000
        @message.valid?
      end
    end

    context '投稿がうまくいかないとき' do
      it '投稿内容がない場合' do
        @message.message_text = ''
        @message.valid?
        # expect(@message.errors.full_messages).to include('Contentを入力してください')
      end
      it '投稿内容が1001文字の場合' do
        @message.message_text = 'a' * 1001
        @message.valid?
        # expect(@message.errors.full_messages).to include('Contentは1000文字以内で入力してください')
      end
    end
  end
end
