#TODO: ゲストユーザー用のログイン機能を追加
class GuestUserLoginController < UsersController
  def create
    guest = User.find_by(email: 'guest@example.com',password: 'password') 
    session[:user_id] = guest.id
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to ("/posts/index")
  end
end
