require 'rails_helper'

describe CardsController do
  before do
    @user = FactoryBot.create(:user)
    describe 'GET #new' do
      it "new.html.hamlに遷移すること" do
        get :new
        expect(response).to render_template :new
      end
    end
    describe 'GET #show' do
      it "show.html.hamlに遷移すること" do
        @user = FactoryBot.create(:user)
        get :show, params: {id: user }
        expect(response).to render_template :show
      end
    end
  end

end