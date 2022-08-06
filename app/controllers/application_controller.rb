class ApplicationController < ActionController::Base

  before_action :set_current_user
  before_action :fetch_the_my_teams, except: [:top, :about]
  before_action :fetch_the_rooms, except: [:top, :about]

  rescue_from Exception,                      with: :render_500
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # sidebar.html.erbで所属チーム一覧を表示
  def fetch_the_my_teams
    @members = @current_user.members.includes(:team) if @current_user
  end

  # sidebar.html.erbでトークルーム一覧を表示
  def fetch_the_rooms
    if @current_user
      @rooms = @current_user.room_users.includes(:room)
      @rooms_id = @rooms.pluck(:room_id)

      # N＋1にならないように includes を使用
      # where.not で、自分のレコードは除外されるように設定
      @room_user = RoomUser.includes(:room).where.not(user_id: @current_user.id).where(room_id: @rooms_id).select(:user_id, :room_id)

      # fetch_the_my_teamsメソッドで設定した@membersのteam_idに
      # 該当するレコードからroom_idを切り出し(重複させたくないルーム)
      @belong_team = Team.where(id: @members.pluck(:team_id)).pluck(:room_id)

      # where.notで、@belong_teamで取得した除外したいルームを設定
      @not_team_members = @room_user.where.not(room_id: @belong_team)
    end
  end

  def authenticate_user
    if @current_user == nil
      redirect_to new_login_path
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to tickets_path
    end
  end

  def render_404(e)
    # 動的ページ
    render "error_404", status: 404, formats: [:html]

    # 静的ページ
    # render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  def render_500(e)
    logger.error [e, *e.backtrace].join("\n")
    # 静的ページ
    render file: Rails.root.join('public/500.html'), status: 500, layout: false, content_type: 'text/html'
  end
end
