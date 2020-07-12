class LikesController < ApplicationController

  def index
    @like_items = Like.where(user_id: current_user.id)
    @likes_counts = Like.group(:item_id).count 
  end

  def create
    @like = Like.new(like_params)
    @like.save
    likes_count = {like_id: @like.id, likes_count: Like.where(item_id: params[:item_id]).count, action: :create}
    respond_to do |format|
      format.json {render json: likes_count}
      format.html
    end
  end

  def destroy
    @like = Like.find_by(item_id: params[:item_id], user_id: params[:user_id])
    @like.destroy
    likes_count = {like_id: 0, likes_count: Like.where(item_id: params[:item_id]).count, action: :destroy}
    respond_to do |format|
      format.json {render json: likes_count}
      format.html
    end
  end

  private
  def like_params
    params.permit(:user_id, :item_id)
  end



end
