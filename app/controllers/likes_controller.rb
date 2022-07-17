class LikesController < ApplicationController

  before_action :authenticate_user

  def create
    @like = Like.new(
      user_id: @current_user.id,
      ticket_id: params[:ticket_id]
    )
    @like.save
    redirect_to ticket_path(params[:ticket_id])
  end

  def destroy
    @like = Like.find_by(
      user_id: @current_user.id,
      ticket_id: params[:ticket_id]
    )
    @like.destroy
    redirect_to ticket_path(params[:ticket_id])
  end

end
