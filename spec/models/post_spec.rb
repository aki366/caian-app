require 'rails_helper'

RSpec.describe "Posts Model", type: :model do
  before do
    @post = FactoryBot.build(:post)
  end
  
  describe '#create' do
    context '投稿内容が1文字のとき' do
      it '投稿が成功すること' do
        @post.content = 'a' * 1
        @post.valid?
      end
    end
    context '投稿内容がないとき' do
      it '投稿が失敗すること' do
        @post.content = ''
        @post.valid?
        expect(@post.errors.full_messages).to include('Contentを入力してください')
      end
    end
    context '投稿内容が1000文字のとき' do
      it '投稿が成功すること' do
        @post.content = 'a' * 1000
        @post.valid?
      end
    end
    context '投稿内容が1001文字のとき' do
      it '投稿が失敗すること' do
        @post.content = 'a' * 1001
        @post.valid?
        expect(@post.errors.full_messages).to include('Contentは1000文字以内で入力してください')
      end
    end
  end
end
