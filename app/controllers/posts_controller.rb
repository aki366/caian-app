class PostsController < ApplicationController

  before_action :authenticate_user,{only:[:new, :show, :edit, :update, :destroy]}
  before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}

  # postのみ404エラ−に検索機能を実装する際に使用
  # rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404

  def index
    if @current_user == nil
      redirect_to new_login_path
    else
      @posts = Post.all.includes(:user).order(created_at: :desc)
    end
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

    # postのみ404エラ−に検索機能を実装する際に使用
    # def render_404
    #   respond_to do |format|
    #     # defaultの404ページを表示させる場合↓
    #     # format.html { render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html' }
    #     format.html { redirect_to not_found_404_path }
    #     format.xml  { head :not_found_404 }
    #     format.any  { head :not_found_404 }
    #   end
    # end

    def ensure_correct_user
      @post = Post.find(params[:id])
      if @post.user_id != @current_user.id
        redirect_to posts_path
      end
    end

    def post_params
      # formから渡ってきたパラメーターのうち下記２つだけを許容する
      params.require(:post).permit(:content, :image)
    end
end
