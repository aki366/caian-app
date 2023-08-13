class TeamMessagesController < ApplicationController

  before_action :authenticate_user

  def create
    @team = Team.find(params[:team_id])
    @team_message = TeamMessage.new(team_message_params)
    @team_message.user_id = @current_user.id
    @team_message.team_id = @team.id
    if @team_message.save
      redirect_to room_team_path(@team.id)
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @team_message = @team.team_messages.find(params[:id])
    if @current_user.id == @team_message.user.id
      @team_message.destroy
      flash[:notice] = t('flash_messages.message_deleted')
      redirect_to room_team_path(@team.id)
    end
  end

  private

    def team_message_params
      params.require(:team_message).permit(:text)
    end
end
