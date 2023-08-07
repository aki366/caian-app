class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :fetch_the_my_teams, except: %i[top about]
  before_action :fetch_the_rooms, except: %i[top about]

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # sidebar.html.erbで所属チーム一覧を表示
  def fetch_the_my_teams
    @teams = @current_user.members.includes(:team) if @current_user
  end

  # sidebar.html.erbでトークルーム一覧を表示
  def fetch_the_rooms
    if @current_user
      @rooms = @current_user.room_users.includes(:room)
      @rooms_id = @rooms.pluck(:room_id)
      @room_all = RoomUser.includes(:room)
      @not_current_rooms = @room_all.where.not(user_id: @current_user.id)
      @private_room_id = @not_current_rooms.where(room_id: @rooms_id)
      @private_room_users = @private_room_id.select(:user_id, :room_id)
    end
  end

  def authenticate_user
    redirect_to new_login_path if @current_user == nil
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = t('flash_messages.already_logged_in')
      redirect_to tickets_path
    end
  end
end
