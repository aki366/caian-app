require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  describe '新規コメント投稿' do
    context '投稿がうまくいくとき' do
      it '投稿内容が1文字の場合' do
        @comment.comment_text = 'a' * 1
        @comment.valid?
      end
      it '内容が1000文字の場合' do
        @comment.comment_text = 'a' * 1000
        @comment.valid?
      end
    end

    context '投稿がうまくいかないとき' do
      it '投稿内容がない場合' do
        @comment.comment_text = ''
        @comment.valid?
        # expect(@comment.errors.full_messages).to include('Contentを入力してください')
      end
      it '内容が1001文字の場合' do
        @comment.comment_text = 'a' * 1001
        @comment.valid?
        # expect(@comment.errors.full_messages).to include('Contentは1000文字以内で入力してください')
      end
    end
  end
end
