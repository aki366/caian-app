class UsersController < ApplicationController

  before_action :authenticate_user,{only:[:index, :show, :edit, :update]}
  before_action :forbid_login_user,{only:[:new, :create, :login_form, :login]}
  before_action :ensure_correct_user,{only:[:edit, :update]}

  def index
    @users = User.all
  end

  def show 
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      user_image: "default_user.jpg",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id:params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    redirect_to("/users/#{@user.id}") and return if @user.guest?
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.user_image = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.user_image}",image.read)
    end
      
    #TODO: ゲストユーザーは更新できないようにする
    #if @user.save
    if !@user.guest? && @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
    # @user = User.login_form
  end
  
  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to ("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  #FIXME: privateメソッドの追加
  private

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice]= "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
