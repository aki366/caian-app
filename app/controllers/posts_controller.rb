class PostsController < ApplicationController

  before_action :authenticate_user,{only:[:edit, :update]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show 
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def new
    @post = Post.new
    if @current_user == nil
      flash[:notice] ="ログインが必要です"
      redirect_to("/login")
    end
  end

  def create
    #TODO: Userモデルとのアソシエーション
    #TODO: あらかじめuser_idが入った状態でPostモデルがnewされる
    #TODO: Post.new
    #TODO: => id: nil, content: nil, created_at: nil, updated_at: nil, user_id: nil>
    #TODO: User.find(1).posts.new
    #TODO: => <id: nil, content: nil, created_at: nil, updated_at: nil, user_id: 1>
    @post = @current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to posts_path
    else
      render new_post_path
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to posts_path
    else
      # render("posts/edit")
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  private

  def post_params
    #formから渡ってきたパラメーターのうち下記２つだけを許容する
    params.require(:post).permit(:content, :image)
  end
end
