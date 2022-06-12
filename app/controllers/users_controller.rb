class UsersController < ApplicationController

  before_action :forbid_login_user,{only:[:new, :create]}
  # ensure_correct_userが実行される前に検査するため
  # ensure_correct_userよりもauthenticate_userを上に記述
  before_action :authenticate_user, {only:[:show, :edit, :update]}
  before_action :ensure_correct_user,{only:[:edit, :update]}
  before_action :set_user, {only:[:show, :edit, :update]}

  def index
    if @current_user == nil
      redirect_to new_login_path
    end
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.includes(:user)
    # 各ユーザーが持つroomのid一覧を配列で取得
    @current_user_rooms = @current_user.rooms.pluck(:id)
    @another_user_rooms = @user.rooms.pluck(:id)

    # 取得した配列の積集合を取る
    @room_ids = @current_user_rooms & @another_user_rooms
    if @user.id == @current_user.id
    else
      # 空でない場合は既に共通のroom idが存在する=ルーム作成済みと判定
      @isRoom = !@room_ids.empty?
      if @isRoom
        @roomId = @room_ids.first
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

    # user/editの入力フォームの値がnilでなければ
    # trueとなりインスタンス変数の@user.XXに代入される
    @user.name = params[:name] if params[:name]
    @user.email = params[:email] if params[:email]
    @user.password = params[:password] if params[:password]

    image = params[:image]
    hash = SecureRandom.hex(10)
    @user.user_image = "#{@user.name}_#{hash}.jpg" if image
    if @user.save
      # もしイメージがパラメーターに含まれていれば、
      # write_imageメソッドを呼び出す。
      # user情報編集は理解しやすいよう、かたまりで上にまとめて、
      # 保存に成功した時点で画像をファイルに書き込む。
      write_image(@user.user_image, image) if image
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to user_path(@user.id)
    else
      @user.user_image = image
      # 同じコントローラ内のeditのビューを表示
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to root_path
  end

  def likes
    # 仮に/users/1/likesというリクエストを受取った場合
    # id:'1'を取得し、User.find(id:1)となる
    @user = User.find(params[:id])
    # @userで取得したidに関連するlikesを取得
    # likesに紐づくpost:(関連1)を紐付け
    # 関連1に紐づく、:user(関連2)の情報を取得
    @likes = @user.likes.includes(post: :user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    # write_imageメソッドは第一引数に画像ファイル名, 
    # 第二引数にイメージを必要とする
    #（file_name == @user.user_image, image == params[:image]）
    def write_image(file_name, image)
      File.binwrite("public/user_images/#{file_name}",image.read)
    end

    # 自分だけが編集できるように
    # ensure_correct_userという現在のuser_idと
    # 対象のuser_idが一致していないとはじくメソッド
    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        redirect_to posts_path
      end
    end

    def user_params
      # ストロングパラメーター
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
