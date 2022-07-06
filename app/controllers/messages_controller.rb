class MessagesController < ApplicationController

  before_action :authenticate_user

  def create
    @room = Room.find(params[:room_id])
    @message = Message.new(message_params)
    @message.user_id = @current_user.id
    @message.room_id = @room.id
    if @message.save
      flash[:notice] = "投稿しました"
      redirect_to room_path(@room.id)
    else
      redirect_to room_path(@room.id)
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @message = @room.messages.find(params[:id])
    if @current_user.id == @message.user.id
      @message.destroy
      redirect_to room_path(@room.id)
    else
      redirect_to room_path(@room.id)
    end
  end

  private

    def message_params
      # formから渡ってきたパラメーターのうちmessage_textだけを許容する
      params.require(:message).permit(:message_text)
    end
end
