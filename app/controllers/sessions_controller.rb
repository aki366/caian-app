class SessionsController < ApplicationController
  before_action :forbid_login_user, {only: %i[new create]}

  def new
    # ログインフォームのviewで使用するため@userを定義
    @user = User.new
  end

  def create
    @user = User.find_by(email: login_params[:email])&.authenticate(login_params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = t('flash_messages.logged_in')
      redirect_to tickets_path
    else
      flash[:notice] = t('flash_messages.login_failed')
      @email = params[:email]
      @password = params[:password]
      redirect_to new_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('flash_messages.logged_out')
    redirect_to new_login_path
  end

  private

    def login_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
