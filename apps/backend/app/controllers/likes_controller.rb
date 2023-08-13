class LikesController < ApplicationController

  before_action :authenticate_user

  def create
    @team = Team.find(params[:id])
    @like = Like.new(
      user_id: @current_user.id,
      ticket_id: params[:ticket_id]
    )
    @like.save
    redirect_to room_team_path(@team.id)
  end

  def destroy
    @team = Team.find(params[:id])
    @like = Like.find_by(
      user_id: @current_user.id,
      ticket_id: params[:ticket_id]
    )
    @like.destroy
    redirect_to room_team_path(@team.id)
  end
end
