class UsersController < ApplicationController

  def show
    @user_items_count = Item.where(user_id: current_user.id).count
    @parents = Category.where(ancestry: nil)
  end
end
