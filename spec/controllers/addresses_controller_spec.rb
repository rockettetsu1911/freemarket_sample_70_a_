require 'rails_helper'

describe AddressesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @address = FactoryBot.create(:address)
    sign_in @user
    binding.pry
  end

  describe 'GET #edit' do
    subject { get :edit, params }
    let(:address) { create(:address, user: user)}
    let(:params) do
      { 
        user_id: @user.id,
        address_id: @user.address.id
      }
    end

      it "@userに正しい値が入っていること" do
        expect(assigns(:user)).to eq @user
      end

      it "@addressに正しい値が入っていること" do
        expect(assigns(:address)).to eq @user.address
      end

      it "edit.html.hamlに遷移すること" do
        expect(response).to render_template :edit
      end
  end

end