class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = @current_user.id
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to post_path(@post.id)
    else
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @current_user.id == @comment.user.id
      @comment.destroy
      redirect_to post_path(@post.id)
    end
  end

  private

    def comment_params
      # formから渡ってきたパラメーターのうちcomment_textだけを許容する
      params.require(:comment).permit(:comment_text)
    end
end
