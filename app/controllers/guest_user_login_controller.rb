class GuestUserLoginController < UsersController
  def create
    guest = User.find_by(email: 'guest@example.com')&.authenticate('password')
    session[:user_id] = guest.id
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to posts_path
  end
end
