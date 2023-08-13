class GuestUserLoginController < UsersController
  def create
    guest = User.find_by(email: 'guest@example.com')&.authenticate('password')
    session[:user_id] = guest.id
    flash[:notice] = t('flash_messages.logged_in')
    redirect_to tickets_path
  end
end
