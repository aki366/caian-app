class TeamsController < ApplicationController

  before_action :authenticate_user

  def new
    @team = Team.new
  end

  def create
    room_id = Room.last.id + 1
    @room = Room.new(id: room_id)
    @team = Team.new(name: team_params[:name], room_id: @room.id)
    if team_params[:name] == ""
      render :new
    else
      if @room.save
        @team.save
        @room_user = @room.room_users.create(
          user_id: @current_user.id
        )
        @member = @team.members.create(
          user_id: @current_user.id,
          team_id: @team.id
        )
        flash[:notice] = "チームを作成しました"
        redirect_to "/teams/#{@team.id}"
      end
    end
  end

  def show
    if @current_user == nil
      redirect_to new_login_path
    else
      @team = Team.find(params[:id])
      @members = @team.members.includes(:user)
    end
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end
end
