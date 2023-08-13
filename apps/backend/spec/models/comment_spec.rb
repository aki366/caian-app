require 'rails_helper'

RSpec.describe "Comments Model", type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  describe '#create' do
    context '投稿内容が1文字のとき' do
      it '投稿が成功すること' do
        @comment.text = 'a' * 1
        @comment.valid?
      end
    end
    context '投稿内容がないとき' do
      it '投稿が失敗すること' do
        @comment.text = ''
        @comment.valid?
        # expect(@comment.errors.full_messages).to include('Contentを入力してください')
      end
    end
    context '投稿内容が1000文字のとき' do
      it '投稿が成功すること' do
        @comment.text = 'a' * 1000
        @comment.valid?
      end
    end
    context '投稿内容が1001文字のとき' do
      it '投稿が失敗すること' do
        @comment.text = 'a' * 1001
        @comment.valid?
        # expect(@comment.errors.full_messages).to include('Contentは1000文字以内で入力してください')
      end
    end
  end
end
