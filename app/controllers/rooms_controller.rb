class RoomsController < ApplicationController
  def create
    @room = Room.new(room_params)
    @room.save
    redirect_to new_room_path(@room)
  end

  def new; end

  private

    def room_params
      params.permit(user_ids: [])
    end
end
