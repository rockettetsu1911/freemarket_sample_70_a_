require 'rails_helper'

describe AddressesController, type: :controller do
  before do
    @address = FactoryBot.create(:address)
    sign_in @address.user
  end

  describe 'GET #edit' do
    it "@userに正しい値が入っていること" do
      get :edit, params: {user_id: @address.user.id, id: @address.id}
      expect(assigns(:user)).to eq @address.user
    end

    it "@addressに正しい値が入っていること" do
      get :edit, params: {user_id: @address.user.id, id: @address.id}
      expect(assigns(:address)).to eq @address
    end

    it "edit.html.hamlに遷移すること" do
      get :edit, params: {user_id: @address.user.id, id: @address.id}
      expect(response).to render_template :edit
    end
  end

end