require 'rails_helper'

RSpec.describe 'Posts #update system', type: :system do

  describe 'ログインしているとき' do
    context 'パラメータが正常な場合' do
      it '投稿内容が更新されること' do
      end
    end
    context '投稿内容がない場合' do
      it '投稿内容が更新されないこと' do
      end
    end
    context '投稿内容が1001文字の場合' do
      it '投稿内容が更新されないこと' do
      end
    end
  end
end
