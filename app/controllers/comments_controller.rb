class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      #respond_to do |format|
        #format.json
        flash[:notice] = 'コメントしました。'
        redirect_to item_path(@comment.item.id)
      end
    # else
    #  flash[:notice] = 'コメント出来ませんでした。'
    #  redirect_to item_path(params[:id])
    # end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.text = 'このコメントは出品者によって削除されました。'
    comment.save
  end

private
  def comment_params
    params.require(:comment).permit(:text,:item_id).merge(user_id: current_user.id)
  end

  ## ユーザーがログインしていない場合のコントローラー？
end
