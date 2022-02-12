class PostsController < ApplicationController
  def index
    @posts = [
      "Caianというサービスをコツコツ開発していきまーす！","投稿一覧ページ作成中！"
    ]
  end
end