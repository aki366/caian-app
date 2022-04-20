require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end
  
  describe '新規投稿' do
    context '新規投稿がうまくいくとき' do
      it '投稿内容が1文字の場合' do
        @post.content = 'a' * 1
        @post.valid?
      end
      it '内容が1000文字の場合' do
        @post.content = 'a' * 1000
        @post.valid?
      end
    end

    context '新規投稿がうまくいかないとき' do
      it '投稿内容がない場合' do
        @post.content = ''
        @post.valid?
        expect(@post.errors.full_messages).to include('Contentを入力してください')
      end
      it '内容が1001文字の場合' do
        @post.content = 'a' * 1001
        @post.valid?
        expect(@post.errors.full_messages).to include('Contentは1000文字以内で入力してください')
      end
    end
  end
end
