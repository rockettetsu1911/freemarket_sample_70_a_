require 'rails_helper'

describe Item do
  describe '#create' do
    it '項目がすべて存在すれば出品できること' do
      user = create(:user)
      category = create(:category)
      item = build(:item, user_id: user.id, category_id: category.id)
      expect(item).to be_valid
    end

    # it 'nameがない場合は出品できないこと' do
    #   item = build(:item, name: '')
    #   item.valid?
    #   expect(item.errors[:name]).to include('を入力してください')
    # end

    # it 'nameが40文字より長い場合は出品できないこと' do
    #   item = build(:item, name: 'あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあ')
    #   item.valid?
    #   expect(item.errors[:name]).to include('は40文字以内で入力してください')
    # end

    # it 'nameが40文字以内の場合は出品できること' do
    #   item = build(:item, name: 'あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえおかきくけこ')
    #   item.valid?
    #   expect(item).to be_valid
    # end
    
    # it 'priceがない場合は出品できないこと' do
    #   item = build(:item, price: nil)
    #   item.valid?
    #   expect(item.errors[:price]).to include('を入力してください')
    # end
    
    # it 'priceが9,999,999より大きい場合は出品できないこと' do
    #   item = build(:item, price: '10000000')
    #   item.valid?
    #   expect(item.errors[:price]).to include('は9999999以下の値にしてください')
    # end
    
    # it 'priceが9,999,999以下の場合は出品できること' do
    #   item = build(:item, price: 9999999)
    #   item.valid?
    #   expect(item).to be_valid
    # end
    
    # it 'priceが300より小さい場合は出品できないこと' do
    #   item = build(:item, price: 299)
    #   item.valid?
    #   expect(item.errors[:price]).to include('は300以上の値にしてください')
    # end
    
    # it 'priceが300以上の場合は出品できること' do
    #   item = build(:item, price: 300)
    #   item.valid?
    #   expect(item).to be_valid
    # end
    
    # it 'priceがフォーマットに則っていない場合は出品できないこと（整数）' do
    #   item = build(:item, price: 'testprice')
    #   item.valid?
    #   expect(item.errors[:price]).to include('は数値で入力してください')
    # end

  end
end