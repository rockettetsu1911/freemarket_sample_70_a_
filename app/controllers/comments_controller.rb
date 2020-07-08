class CommentsController < ApplicationController

  before_action :move_to_login, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @current_user = current_user
    @item = Item.find(@comment.item_id)
    if @comment.save
      respond_to do |format|
        format.json
      end
     else
      flash[:alert] = 'コメント出来ませんでした。'
      end
  end

  def update
    comment = Comment.find(params[:id])
    comment.text = 'このコメントは出品者によって削除されました。'
    comment.comment_status = 1
    comment.save
  end

private
  def comment_params
    params.require(:comment).permit(:text,:item_id).merge(user_id: current_user.id)
  end

  def move_to_login
    redirect_to user_session_path unless user_signed_in?
  end
  
end
