class UsersController < ApplicationController
  before_action :update_params, only: :update

  def show
    @user_items_count = Item.where(user_id: current_user.id).count
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    binding.pry
    if @user.save
      redirect_to edit_user_path(@user.id)
      flash[:notice] = 'プロフィールを更新しました'
    else
      redirect_to edit_user_path(@user.id)
      flash[:alert] = 'プロフィール変更に失敗しました。'
    end
  end

  protected

  def update_params
    params.require(:user).permit(:nickname, :introduction).merge(password: current_user.password)
  end
end
