class UsersController < ApplicationController

  before_action :authenticate_user,{only:[:index, :show, :edit, :update]}
  before_action :forbid_login_user,{only:[:new, :create, :login_form, :login]}
  before_action :ensure_correct_user,{only:[:edit, :update]}
  before_action :set_user, {only:[:show, :edit, :update]}

  def index
    @users = User.all
  end

  def show 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    redirect_to user_path(@user.id) and return if @user.guest?

    @user.name = params[:name]
    @user.email = params[:email]
    @user.user_image = "#{@user.id}.jpg"

    if @user.save
      #もしイメージがパラメーターに含まれていれば、write_imageメソッドを呼び出す。
      # user情報編集は理解しやすいよう、かたまりで上にまとめて、保存に成功した時点で画像をファイルに書き込みます。
      write_image(@user.user_image, params[:image]) if params[:image]
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to user_path(@user.id)
    else
      render edit_user_path
    end
  end

  def login_form
    # ログインフォームのviewで使用するため@userを定義
    @user = User.new
  end
  
  def login
    @user = User.find_by(login_params)
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render login_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end

  # privateメソッドの追加
  private

  def set_user
    @user = User.find_by(id: params[:id])
  end


  # write_imageメソッドは第一引数に画像ファイル名, 第二引数にイメージを必要とする
  #（file_name == @user.user_image, image == params[:image]）
  def write_image(file_name, image)
    image = params[:image]
    File.binwrite("public/user_images/#{file_name}",image.read)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice]= "権限がありません"
      redirect_to posts_path
    end
  end

  private

  def user_params
    # ストロングパラメーター
    params.require(:user).permit(:name, :email, :password)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
