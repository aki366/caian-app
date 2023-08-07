class MessagesController < ApplicationController

  before_action :authenticate_user

  def create
    @room = Room.find(params[:room_id])
    @message = Message.new(message_params)
    @message.user_id = @current_user.id
    @message.room_id = @room.id
    if @message.save
      flash[:notice] = t('flash_messages.message_posted')
      redirect_to room_path(@room.id)
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @message = @room.messages.find(params[:id])
    if @current_user.id == @message.user.id
      @message.destroy
      redirect_to room_path(@room.id)
    end
  end

  private

    def message_params
      # formから渡ってきたパラメーターのうちtextだけを許容する
      params.require(:message).permit(:text)
    end
end
