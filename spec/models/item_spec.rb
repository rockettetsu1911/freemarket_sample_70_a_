require 'rails_helper'
 
describe Item do
  describe '#create' do
 
    it '項目がすべて存在すれば出品できること' do
      item = build(:item_valid)
      expect(item).to be_valid
    end  
  
    it 'nameがない場合は出品できないこと' do
      item = build(:item_valid, name: nil)
      item.valid?
      expect(item.errors[:name]).to include('を入力してください')
    end
  
    it 'nameが40文字より長い場合は出品できないこと' do
      item = build(:item_valid, name: 'あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあ')
      item.valid?
      expect(item.errors[:name]).to include('は40文字以内で入力してください')
    end
  
    it 'nameが40文字以内の場合は出品できること' do
      item = build(:item_valid, name: 'あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえおかきくけこ')
      item.valid?
      expect(item).to be_valid
    end
    
    it 'priceがない場合は出品できないこと' do
      item = build(:item_valid, price: nil)
      item.valid?
      expect(item.errors[:price]).to include('を入力してください')
    end
    
    it 'priceが9,999,999より大きい場合は出品できないこと' do
      item = build(:item_valid, price: '10000000')
      item.valid?
      expect(item.errors[:price]).to include('は9999999以下の値にしてください')
    end
    
    it 'priceが9,999,999以下の場合は出品できること' do
      item = build(:item_valid, price: 9999999)
      item.valid?
      expect(item).to be_valid
    end
    
    it 'priceが300より小さい場合は出品できないこと' do
      item = build(:item_valid, price: 299)
      item.valid?
      expect(item.errors[:price]).to include('は300以上の値にしてください')
    end
    
    it 'priceが300以上の場合は出品できること' do
      item = build(:item_valid, price: 300)
      item.valid?
      expect(item).to be_valid
    end
    
    it 'priceがフォーマットに則っていない場合は出品できないこと（整数）' do
      item = build(:item_valid, price: 'testprice')
      item.valid?
      expect(item.errors[:price]).to include('は数値で入力してください')
    end
    
    it 'conditionがない場合は出品できないこと' do
      item = build(:item_valid, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include('を入力してください')
    end
    
    it 'conditionが選択されていない場合は出品できないこと' do
      item = build(:item_valid, condition: '---')
      item.valid?
      expect(item.errors[:condition]).to include('を入力してください')
    end
    
    it 'explanationがない場合は出品できないこと' do
      item = build(:item_valid, explanation: nil)
      item.valid?
      expect(item.errors[:explanation]).to include('を入力してください')
    end
    
    it 'explanationが1000文字より長い場合は出品できないこと' do
      item = build(:item_valid, explanation: Faker::Lorem.characters(number: 1001))
      item.valid?
      expect(item.errors[:explanation]).to include('は1000文字以内で入力してください')
    end
    
    it 'explanationが1000文字以内の場合は出品できること' do
      item = build(:item_valid, explanation: Faker::Lorem.characters(number: 1000))
      item.valid?
      expect(item).to be_valid
    end
    
    it 'category_idがない場合は出品できないこと' do
      item = build(:item_without_category)
      item.valid?
      expect(item.errors[:category_id]).to include('を入力してください')
    end
    
    it 'picturesがない場合は出品できないこと' do
      item = build(:item_without_picture)
      item.valid?
      expect(item.errors[:pictures]).to include('を入力してください')
    end
    
    it 'picturesが1枚以上なら出品できること' do
      item = build(:item_with_a_picture)
      item.valid?
      expect(item).to be_valid
    end
    
    it 'picturesが10枚より多い場合は出品できないこと' do
      item = build(:item_with_eleven_pictures)
      item.valid?
      expect(item.errors[:pictures]).to include('は10枚以内で入力してください')
    end
 
    it 'picturesが10枚以内の場合は出品できること' do
      item = build(:item_with_ten_pictures)
      item.valid?
      expect(item).to be_valid
    end
 
  end  
end
