class AddressesController < ApplicationController
  def new
  end

  def create
    @address = Address.new(address_params)
    binding.pry 
    if @address.save
      redirect_to user_path(current_user.id), notice: '発送元・送付先住所を登録しました'
    else
      render :new
    end
  end
  
  def show
    @address = Address.user_id(current_user.id)
  end

  def edit
  end

  private
  def address_params
    params.permit(:dest_first_name, :dest_last_name, :dest_first_name_kana, :dest_last_name_kana, :zip_code, :prefecture, :city, :block_number, :building, :telephone, :user_id)
  end

end
