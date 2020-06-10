class UsersController < ApplicationController

  def show
    @user_address = User.find(current_user.id).address
  end
end
