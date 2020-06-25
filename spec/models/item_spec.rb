require 'rails_helper'
 
describe Item do
  describe '#update' do
    let(:changed_str) {'編集'}
    let(:changed_int) {12345}
    let(:item) { create(:item_valid) }
 
    context 'success' do
      it 'nameを編集できること' do
        params = item.attributes
        params[:name] = changed_str
        item.update(params)
        expect(item.name).to eq changed_str
      end  

      it 'explanationを編集できること' do
        params = item.attributes
        params[:explanation] = changed_str
        item.update(params)
        expect(item.explanation).to eq changed_str
      end

      it 'priceを編集できること' do
        params = item.attributes
        params[:price] = changed_int
        item.update(params)
        expect(item.price).to eq changed_int
      end

      it 'conditionを編集できること' do
        params = item.attributes
        params[:condition] = 'nearly_unused'
        item.update(params)
        expect(item.condition).to eq 'nearly_unused'
      end
      
      it 'category_idを編集できること' do
        params = item.attributes
        params[:category_id] = 992
        item.update(params)
        expect(item.category_id).to eq 992
      end
      
    end
    
    context 'fail' do
      it 'nameがなければ編集できないこと' do
        params = item.attributes
        params[:name] = nil
        item.update(params)
        item.valid?
        expect(item.errors[:name]).to include('を入力してください')
      end
      
      it 'explanationがなければ編集できないこと' do
        params = item.attributes
        params[:explanation] = nil
        item.update(params)
        item.valid?
        expect(item.errors[:explanation]).to include('を入力してください')
      end
      
      it 'priceがなければ編集できないこと' do
        params = item.attributes
        params[:price] = nil
        item.update(params)
        item.valid?
        expect(item.errors[:price]).to include('を入力してください')
      end
      
      it 'conditionがなければ編集できないこと' do
        params = item.attributes
        params[:condition] = nil
        item.update(params)
        item.valid?
        expect(item.errors[:condition]).to include('を入力してください')
      end
      
      it 'category_idがなければ編集できないこと' do
        params = item.attributes
        params[:category_id] = nil
        item.update(params)
        item.valid?
        expect(item.errors[:category_id]).to include('を入力してください')
      end
      
      it 'user_idがなければ編集できないこと' do
        params = item.attributes
        params[:user_id] = nil
        item.update(params)
        item.valid?
        expect(item.errors[:user_id]).to include('を入力してください')
      end

    end
  end
  
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
 
    it 'postage_idがない場合は出品できないこと' do
      item = build(:item, postage_id: nil)
      item.valid?
      expect(item.errors[:postage_id]).to include('を入力してください')
    end
 
    it 'postageが1,2以外の場合は出品できないこと' do
      item = build(:item, postage_id: 3)
      item.valid?
      expect(item.errors[:postage_id]).to include('は2以下の値にしてください')
    end
 
    it 'prefectureが選択されていない場合は出品できないこと' do
      item = build(:item, prefecture: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include('を入力してください')
    end
 
    it 'prefectureが1-47以外の場合は出品できないこと' do
      item = build(:item, prefecture_id: 48)
      item.valid?
      expect(item.errors[:prefecture_id]).to include('は47以下の値にしてください')
    end
 
    it 'delivery_dateがない場合は出品できないこと' do
      item = build(:item, delivery_date_id: nil)
      item.valid?
      expect(item.errors[:delivery_date_id]).to include('を入力してください')
    end
 
    it 'delivery_dateが1,2以外の場合は出品できないこと' do
      item = build(:item, delivery_date_id: 3)
      item.valid?
      expect(item.errors[:delivery_date_id]).to include('は2以下の値にしてください')
    end
 
    
    it 'users_idがない場合は出品できないこと' do
      item = build(:item_without_user)
      item.valid?
      expect(item.errors[:user_id]).to include('を入力してください')
    end
    
  end  
end
