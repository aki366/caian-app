class PostsController < ApplicationController

  before_action :authenticate_user,{only:[:edit, :update]}

  skip_before_action :verify_authenticity_token

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
    # アソシエーションを用いることで、user_idカラムにcurrent_user.idが入る
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end

  def update
    @post = Post.find_by(id:params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      redirect_to("/posts/#{@post.id}/edit")
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
    params.require(:post).permit(:content, :image) #ここにimageを追加する
  end

end
