require 'rails_helper'

describe Card do
  describe '#create' do
    it "項目がすべて存在すれば登録できること" do
      user = create(:user)
      card = build(:card)
      expect(card).to be_valid
    end

    it "user_idがない場合は登録出来ないこと" do
      card = build(:card, user_id: nil)
      card.valid?
      expect(card.errors[:user]).to include("を入力してください")
    end

    it "card_idがない場合は登録できないこと" do
      card = build(:card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end

    it "customer_idがない場合は登録できないこと" do
      card = build(:card, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end

  end
end

  
