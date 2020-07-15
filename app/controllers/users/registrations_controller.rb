# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_account_update_params, only: [:profile_update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      @nickname_present = true if User.find_by(nickname: @user.nickname).present?
      @email_present = true if User.find_by(email: @user.email).present?
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to root_path, notice: '登録が完了しました。'

  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def profile_edit
    @user = current_user
  end

  def profile_update
    user = current_user
    binding.pry
    if user.update(update_resources())
      redirect_to profile_edit_path
      flash[:notice] = 'プロフィールを更新しました'
    else
      redirect_to profile_edit_path
      flash[:alert] = 'プロフィール変更に失敗しました。'
    end
  end

  private

  def update_params
    params.permit(:nickname, :introduction)
  end
  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, :telephone, :introduction])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :introduction])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def address_params
    params.require(:address).permit(:dest_last_name, :dest_first_name, :dest_last_name_kana, :dest_first_name_kana, :zip_code, :prefecture, :city, :block_number, :building, :telephone)
  end

end
