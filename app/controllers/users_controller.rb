class UsersController < ApplicationController
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
      user_image: "default_user.jpg"
    )
    if @user.save
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
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.user_image = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.user_image}",image.read)
    end
      
    if @user.save
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
      flash[:notice] = "ログインしました"
      redirect_to ("/posts/index")
    else
      render("users/login_form")
    end
  end

end
