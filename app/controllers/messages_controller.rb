class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = Message.new(message_params)
    @message.user_id = @current_user.id
    @message.room_id = @room.id
    if @message.save
      flash[:notice] = "投稿しました"
      redirect_to room_path(@room.id)
    end
  end

  private

    def message_params
      # formから渡ってきたパラメーターのうちmessage_textだけを許容する
      params.require(:message).permit(:message_text)
    end
end
