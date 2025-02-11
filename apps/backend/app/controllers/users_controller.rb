class UsersController < ApplicationController

  before_action :forbid_login_user,{only:[:new, :create]}
  # ensure_correct_userが実行される前に検査するため
  # ensure_correct_userよりもauthenticate_userを上に記述
  before_action :authenticate_user, {only:[:show, :index, :edit, :update]}
  before_action :ensure_correct_user,{only:[:edit, :update]}
  before_action :set_user, {only:[:show, :edit, :update]}

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @ticket = @user.tickets

    # 実績
    @categorles = Categorle.all

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

  def edit
  end

  def create
    @user = User.new(user_params)
    image = params[:user][:user_image]
    hash = SecureRandom.hex(10)
    @user.user_image = "#{@user.name}_#{hash}.jpg" if image
    if @user.save
      write_image(@user.user_image, image) if image
      session[:user_id] = @user.id
      flash[:notice] = t('flash_messages.signed_up')
      redirect_to user_path(@user.id)
    else
      @user.user_image = image if image
      render :new
    end
  end

  def update
    return redirect_to user_path(@user.id) if @user.guest?

    update_user_attributes
    update_user_image if params[:image]

    if @user.save
      write_image(@user.user_image, params[:image]) if params[:image]
      flash[:notice] = t('flash_messages.user_updated')
      redirect_to user_path(@user.id)
    else
      @user.user_image = params[:image]
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = t('flash_messages.user_deleted')
    redirect_to root_path
  end

  def likes
    # 仮に/users/1/likesというリクエストを受取った場合
    # id:'1'を取得し、User.find(id:1)となる
    @user = User.find(params[:id])
    # @userで取得したidに関連するlikesを取得
    # likesに紐づくticket:(関連1)を紐付け
    # 関連1に紐づく、:user(関連2)の情報を取得
    @likes = @user.likes.includes(ticket: :user)
  end

  def teams
    @user = User.find(params[:id])
    @teams = @user.members.includes(:team)
  end

  private

    def update_user_attributes
      @user.name = params[:name] if params[:name]
      @user.email = params[:email] if params[:email]
      @user.password = params[:password] if params[:password]
    end

    def update_user_image
      hash = SecureRandom.hex(10)
      @user.user_image = "#{@user.name}_#{hash}.jpg"
    end

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
      redirect_to tickets_path if @current_user.id != params[:id].to_i
    end

    def user_params
      # ストロングパラメーター
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
