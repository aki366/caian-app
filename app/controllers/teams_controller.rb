class TeamsController < ApplicationController

  before_action :authenticate_user

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      @member = Member.new(
        user_id: @current_user.id,
        team_id: @team.id
      )
      @member.save
      flash[:notice] = "チームを作成しました"
      redirect_to new_team_path
    else
      render :new
    end
  end

  def index
    if @current_user == nil
      redirect_to new_login_path
    else
      @teams = Team.includes(:users)
    end
  end

  def show
    if @current_user == nil
      redirect_to new_login_path
    else
    end
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end
end
