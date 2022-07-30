class ApplicationController < ActionController::Base

  before_action :set_current_user
  before_action :fetch_the_teams

  rescue_from Exception,                      with: :render_500
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # sidebar.html.erbで所属チーム一覧を表示
  def fetch_the_teams
    @teams = @current_user.members.includes(:team)
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
