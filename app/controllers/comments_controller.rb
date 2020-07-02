class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.json 
      end
     else
       flash[:alert] = 'コメント出来ませんでした。'
       redirect_to item_path(comment.item_id)
      end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.text = 'このコメントは出品者によって削除されました。'
    comment.comment_status = 1
    comment.save
  end

private
  def comment_params
    params.require(:comment).permit(:text,:item_id).merge(user_id: current_user.id)
  end

  ## ユーザーがログインしていない場合のコントローラー？
end
