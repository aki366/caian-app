class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = @current_user.id
    @comment.ticket_id = @ticket.id
    if @comment.save
      flash[:notice] = t('flash_messages.comment_posted')
      redirect_to ticket_path(@ticket.id)
    else
      redirect_to ticket_path(@ticket.id)
    end
  end

  def destroy
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.find(params[:id])
    if @current_user.id == @comment.user.id
      @comment.destroy
      redirect_to ticket_path(@ticket.id)
    end
  end

  private

    def comment_params
      # formから渡ってきたパラメーターのうちtextだけを許容する
      params.require(:comment).permit(:text)
    end
end
