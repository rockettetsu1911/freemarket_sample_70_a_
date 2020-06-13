class AddressesController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @address = Address.new
  end

  def create
    address = Address.create(address_params)
    if address.save
      redirect_to user_path(current_user.id), notice: '発送元・送付先住所を登録しました'
    else
      flash.now[:alert] = address.errors.full_messages
      render :new and return
    end
  end
  
  def edit
    @user = User.find(current_user.id)
    @address = Address.find(params[:id])
  end

  def update
    address = Address.update(address_params)
    if address
      redirect_to user_path(current_user.id), notice: '発送元・送付先住所を変更しました'
    else
      flash.now[:alert] = address.errors.full_messages
      render :edit and return
    end
  end

  private
  def address_params
    params.permit(:dest_first_name, :dest_last_name, :dest_first_name_kana, :dest_last_name_kana, :zip_code, :prefecture, :city, :block_number, :building, :telephone, :user_id)
  end

end
