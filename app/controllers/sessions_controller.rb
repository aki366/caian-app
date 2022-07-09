class SessionsController < ApplicationController

  before_action :forbid_login_user,{only:[:new, :create]}

  def new
    # ログインフォームのviewで使用するため@userを定義
    @user = User.new
  end

  def create
    @user = User.find_by(email: login_params[:email])&.authenticate(login_params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      flash[:notice] = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      redirect_to new_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to new_login_path
  end

  private

    def login_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
