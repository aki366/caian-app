class PostsController < ApplicationController

  before_action :authenticate_user,{only:[:edit, :update]}

  before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}

  def index
    if @current_user == nil
      redirect_to new_login_path
    end
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @comments = @post.comments.includes(:user)
    @likes = Like.find_by(user_id: @current_user.id, post_id: @post.id)
  end

  def new
    @post = Post.new
    if @current_user == nil
      flash[:notice] ="ログインが必要です"
      redirect_to login_path
    end
  end

  def create
    # Userモデルとのアソシエーション
    # あらかじめuser_idが入った状態でPostモデルがnewされる
    # Post.new
    # => id: nil, content: nil, created_at: nil, updated_at: nil, user_id: nil>
    # User.find(1).posts.new
    # => <id: nil, content: nil, created_at: nil, updated_at: nil, user_id: 1>
    @post = @current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  private

    def post_params
      # formから渡ってきたパラメーターのうち下記２つだけを許容する
      params.require(:post).permit(:content, :image)
    end
end
