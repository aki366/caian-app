class RoomsController < ApplicationController
  def create
    @room = Room.new(room_params)
    @room.save
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if RoomUser.where(:user_id => @current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @room_users = @room.room_users
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
