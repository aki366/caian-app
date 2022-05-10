class UsersController < ApplicationController

  before_action :forbid_login_user,{only:[:new, :create, :login_form, :login]}
  before_action :ensure_correct_user,{only:[:edit, :update]}
  before_action :set_user, {only:[:show, :edit, :update]}

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @current_room_user = RoomUser.where(user_id: @current_user.id)
    @another_room_user = RoomUser.where(user_id: @user.id)
    if @user.id == @current_user.id
    else
      @current_room_user.each do |current|
        @another_room_user.each do |another|
          if current.room_id == another.room_id
            @isRoom = true
            @roomId = current.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @room_user = RoomUser.new
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    image = params[:user][:user_image]
    hash = SecureRandom.hex(10)
    @user.user_image = "#{@user.name}_#{hash}.jpg" if image
    if @user.save
      write_image(@user.user_image, image) if image
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to user_path(@user.id)
    else
      @user.user_image = image if image
      render :new
    end
  end

  def edit
  end

  def update
    redirect_to user_path(@user.id) and return if @user.guest?

    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    image = params[:image]
    hash = SecureRandom.hex(10)
    @user.user_image = "#{@user.name}_#{hash}.jpg" if image
    if @user.save
      #もしイメージがパラメーターに含まれていれば、write_imageメソッドを呼び出す。
      # user情報編集は理解しやすいよう、かたまりで上にまとめて、保存に成功した時点で画像をファイルに書き込みます。
      write_image(@user.user_image, image) if image
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to user_path(@user.id)
    else
      @user.user_image = image
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to root_path
  end

  def login_form
    # ログインフォームのviewで使用するため@userを定義
    @user = User.new
  end
  
  def login
    @user = User.find_by(email: login_params[:email])&.authenticate(login_params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      flash[:notice] = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    # write_imageメソッドは第一引数に画像ファイル名, 第二引数にイメージを必要とする
    #（file_name == @user.user_image, image == params[:image]）
    def write_image(file_name, image)
      File.binwrite("public/user_images/#{file_name}",image.read)
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice]= "権限がありません"
        redirect_to posts_path
      end
    end

    def user_params
      # ストロングパラメーター
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def login_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
