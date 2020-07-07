class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    @like.save
    # render template: "items/show"
    redirect_to item_path(params[:item_id]), method: :get
  end

  def destroy
    like = Like.find_by(item_id: params[:item_id], user_id: params[:user_id])
    like.destroy
    # render template: "items/show"
    redirect_to item_path(params[:item_id]), method: :get
  end

  private
  def like_params
    params.permit(:user_id, :item_id)
  end



end
