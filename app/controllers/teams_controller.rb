class TeamsController < ApplicationController

  before_action :authenticate_user

  def create
    @team = Team.new(team_params)
    @team.save
    flash[:notice] = "チームを作成しました"
    redirect_to new_team_path
  end

  def show
    @team = Team.find(params[:id])
    @message = Message.new
    if Member.where(:user_id => @current_user.id, :team_id => @team.id).present?
      @messages = @team.team_users
      @team_users = @team.messages.includes(:user)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    @team = Team.new
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end
end
