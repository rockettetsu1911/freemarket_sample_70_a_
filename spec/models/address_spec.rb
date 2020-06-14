require 'rails_helper'

describe Address do
  describe '#create'do
  it "必須項目がすべて存在すれば登録できること" do
    address = build(:address)
    expect(address).to be_valid
  end

  it "任意項目（建物・部屋名）があった場合に登録できること" do
    address = build(:address, building: "アジアビル")
    expect(address).to be_valid
  end

  it "任意項目（電話番号）があった場合に登録できること" do
    address = build(:address, telephone: "09012345678")
    expect(address).to be_valid
  end

  it "fist_nameがない場合は登録できないこと" do
    address = build(:address, dest_first_name: nil)
    address.valid?
    expect(address.errors[:dest_first_name]).to include("を入力してください")
  end

  it "dest_first_nameが15文字より長い場合は登録できないこと" do
    address = build(:address, dest_first_name: "テストユーザテストユーザテストユ")
    address.valid?
    expect(address.errors[:dest_first_name]).to include("は15文字以内で入力してください")
  end

  it "dest_first_nameがフォーマットに則っていない場合は登録できないこと" do
    address = build(:address, dest_first_name: "testaddres")
    address.valid?
    expect(address.errors[:dest_first_name]).to include("を正しく入力してください")
  end

  it "dest_last_nameがない場合は登録できないこと" do
    address = build(:address, dest_last_name: nil)
    address.valid?
    expect(address.errors[:dest_last_name]).to include("を入力してください")
  end

  it "dest_last_nameが15文字より長い場合は登録できないこと" do
    address = build(:address, dest_last_name: "テストユーザテストユーザテストユ")
    address.valid?
    expect(address.errors[:dest_last_name]).to include("は15文字以内で入力してください")
  end

  it "dest_last_nameがフォーマットに則っていない場合は登録できないこと" do
    address = build(:address, dest_last_name: "testaddres")
    address.valid?
    expect(address.errors[:dest_last_name]).to include("を正しく入力してください")
  end

  it "fist_name_kanaがない場合は登録できないこと" do
    address = build(:address, dest_first_name_kana: nil)
    address.valid?
    expect(address.errors[:dest_first_name_kana]).to include("を入力してください")
  end

  it "dest_first_name_kanaが30文字より長い場合は登録できないこと" do
    address = build(:address, dest_first_name_kana: "テストユーザテストユーザテストユーザテストユーザテストユーザテ")
    address.valid?
    expect(address.errors[:dest_first_name_kana]).to include("は30文字以内で入力してください")
  end

  it "dest_first_name_kanaがフォーマットに則っていない場合は登録できないこと（全角ひらがな）" do
    address = build(:address, dest_first_name_kana: "てすとゆーざ")
    address.valid?
    expect(address.errors[:dest_first_name_kana]).to include("を正しく入力してください")
  end

  it "dest_last_name_kanaがない場合は登録できないこと" do
    address = build(:address, dest_last_name_kana: nil)
    address.valid?
    expect(address.errors[:dest_last_name_kana]).to include("を入力してください")
  end

  it "dest_last_name_kanaが30文字より長い場合は登録できないこと" do
    address = build(:address, dest_last_name_kana: "テストユーザテストユーザテストユーザテストユーザテストユーザテ")
    address.valid?
    expect(address.errors[:dest_last_name_kana]).to include("は30文字以内で入力してください")
  end

  it "dest_last_name_kanaがフォーマットに則っていない場合は登録できないこと（半角英字）" do
    address = build(:address, dest_last_name_kana: "testaddres")
    address.valid?
    expect(address.errors[:dest_last_name_kana]).to include("を正しく入力してください")
  end

  it "zip_codeがフォーマットに則っていない場合は登録できないこと（半角英字）" do
    address = build(:address, zip_code: "123456u")
    address.valid?
    expect(address.errors[:zip_code]).to include("を正しく入力してください")
  end

  it "zip_codeがフォーマットに則っていない場合は登録できないこと（全角）" do
    address = build(:address, zip_code: "123456う")
    address.valid?
    expect(address.errors[:zip_code]).to include("を正しく入力してください")
  end

  it "zip_codeがフォーマットに則っていない場合は登録できないこと（文字数オーバー）" do
    address = build(:address, zip_code: "12345678")
    address.valid?
    expect(address.errors[:zip_code]).to include("を正しく入力してください")
  end

  it "zip_codeがフォーマットに則っていない場合は登録できないこと（6文字）" do
    address = build(:address, zip_code: "123456")
    address.valid?
    expect(address.errors[:zip_code]).to include("を正しく入力してください")
  end

  it "prefectureがフォーマットに則っていない場合は登録できないこと（数字）" do
    expect{build(:address, prefecture: "13")}.to raise_error(ArgumentError)
  end

  it "prefectureがフォーマットに則っていない場合は登録できないこと（全角）" do
    expect{build(:address, prefecture: "東京")}.to raise_error(ArgumentError)
  end

  it "cityが30文字より長い場合は登録できないこと" do
    address = build(:address, city: "テストユーザテストユーザテストユーザテストユーザテストユーザテ")
    address.valid?
    expect(address.errors[:city]).to include("は30文字以内で入力してください")
  end

  it "cityがフォーマットに則っていない場合は登録できないこと（数字）" do
    address = build(:address, city: "123456")
    address.valid?
    expect(address.errors[:city]).to include("を正しく入力してください")
  end

  it "cityがフォーマットに則っていない場合は登録できないこと（英字）" do
    address = build(:address, city: "shibuya")
    address.valid?
    expect(address.errors[:city]).to include("を正しく入力してください")
  end

  it "block_numberが30文字より長い場合は登録できないこと" do
    address = build(:address, block_number: "テストユーザテストユーザテストユーザテストユーザテストユーザテ")
    address.valid?
    expect(address.errors[:block_number]).to include("は30文字以内で入力してください")
  end

  it "block_numberがフォーマットに則っていない場合は登録できないこと（数字）" do
    address = build(:address, block_number: "123456")
    address.valid?
    expect(address.errors[:block_number]).to include("を正しく入力してください")
  end

  it "block_numberがフォーマットに則っていない場合は登録できないこと（英字）" do
    address = build(:address, block_number: "shibuya")
    address.valid?
    expect(address.errors[:block_number]).to include("を正しく入力してください")
  end

  it "buildingが30文字より長い場合は登録できないこと" do
    address = build(:address, building: "テストユーザテストユーザテストユーザテストユーザテストユーザテ")
    address.valid?
    expect(address.errors[:building]).to include("は30文字以内で入力してください")
  end

  it "buildingがフォーマットに則っていない場合は登録できないこと（数字）" do
    address = build(:address, building: "123456")
    address.valid?
    expect(address.errors[:building]).to include("を正しく入力してください")
  end

  it "buildingがフォーマットに則っていない場合は登録できないこと（英字）" do
    address = build(:address, building: "furima buliding")
    address.valid?
    expect(address.errors[:building]).to include("を正しく入力してください")
  end

  it "telephoneが11文字より長い場合は登録できないこと" do
    address = build(:address, telephone: "012345678912")
    address.valid?
    expect(address.errors[:telephone]).to include("は11文字以内で入力してください")
  end

  it "telephoneが10文字より短い場合は登録できないこと" do
    address = build(:address, telephone: "012345678")
    address.valid?
    expect(address.errors[:telephone]).to include("は10文字以上で入力してください")
  end

  it "user_idが一意でない場合は登録できないこと" do
    user = create(:user)
    address = create(:address, user_id: "1")
    another_address = build(:address)
    another_address.valid?
    expect(another_address.errors[:user_id]).to include("はすでに存在します")
  end

  end
end