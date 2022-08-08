class RoomsController < ApplicationController

  before_action :authenticate_user

  def create
    @room = Room.new(room_params)
    @room.save
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    if RoomUser.where(
      :user_id => @current_user.id,
      :room_id => @room.id
    ).present?
      @room_user = @room.room_users
      @users = @room.messages.includes(:user)
      @not_current_room_user = @room_user.where.not(user: @current_user)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def new; end

  private

    def room_params
      params.permit(user_ids: [])
    end
end
