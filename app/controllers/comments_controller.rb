class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    flash[:notice] = 'コメントしました。'
    redirect_to item_path(@comment.item.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to item_path(@comment.item.id)
  end

private
  def comment_params
    params.require(:comment).permit(:text,:item_id).merge(user_id: current_user.id)
  end

  ## ユーザーがログインしていない場合のコントローラー？
end
