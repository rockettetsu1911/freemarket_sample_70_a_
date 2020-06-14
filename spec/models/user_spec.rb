# require 'rails_helper'

# describe User do
#   describe '#create' do
#     it "項目がすべて存在すれば登録できること" do
#       user = build(:user)
#       expect(user).to be_valid
#     end

#     it "nicknameがない場合は登録できないこと" do
#       user = build(:user, nickname: nil)
#       user.valid?
#       expect(user.errors[:nickname]).to include("を入力してください")
#     end

#     it "nicknameが20文字より長い場合は登録できないこと" do
#       user = build(:user, nickname: "テストユーザテストユーザテストユーザテスト")
#       user.valid?
#       expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
#     end

#     it "nicknameが一意でない場合は登録できないこと" do
#       user = create(:user, email: "testuser2@gmail.com")
#       another_user = build(:user)
#       another_user.valid?
#       expect(another_user.errors[:nickname]).to include("はすでに存在します")
#     end

#     it "emailがない場合は登録できないこと" do
#       user = build(:user, email: nil)
#       user.valid?
#       expect(user.errors[:email]).to include("を入力してください")
#     end

#     it "emailが一意でない場合は登録できないこと" do
#       user = create(:user, nickname: "テストユーザ2")
#       another_user = build(:user)
#       another_user.valid?
#       expect(another_user.errors[:email]).to include("はすでに存在します")
#     end

#     it "emailがメールフォーマットに則っていない場合は登録できないこと" do
#       user = build(:user, email: "testusergmail.com")
#       user.valid?
#       expect(user.errors[:email]).to include("を正しく入力してください")
#     end

#     it "fist_nameがない場合は登録できないこと" do
#       user = build(:user, first_name: nil)
#       user.valid?
#       expect(user.errors[:first_name]).to include("を入力してください")
#     end

#     it "first_nameが15文字より長い場合は登録できないこと" do
#       user = build(:user, first_name: "テストユーザテストユーザテストユ")
#       user.valid?
#       expect(user.errors[:first_name]).to include("は15文字以内で入力してください")
#     end

#     it "first_nameがフォーマットに則っていない場合は登録できないこと" do
#       user = build(:user, first_name: "testuser")
#       user.valid?
#       expect(user.errors[:first_name]).to include("を正しく入力してください")
#     end

#     it "last_nameがない場合は登録できないこと" do
#       user = build(:user, last_name: nil)
#       user.valid?
#       expect(user.errors[:last_name]).to include("を入力してください")
#     end

#     it "last_nameが15文字より長い場合は登録できないこと" do
#       user = build(:user, last_name: "テストユーザテストユーザテストユ")
#       user.valid?
#       expect(user.errors[:last_name]).to include("は15文字以内で入力してください")
#     end

#     it "last_nameがフォーマットに則っていない場合は登録できないこと" do
#       user = build(:user, last_name: "testuser")
#       user.valid?
#       expect(user.errors[:last_name]).to include("を正しく入力してください")
#     end

#     it "fist_name_kanaがない場合は登録できないこと" do
#       user = build(:user, first_name_kana: nil)
#       user.valid?
#       expect(user.errors[:first_name_kana]).to include("を入力してください")
#     end

#     it "first_name_kanaが30文字より長い場合は登録できないこと" do
#       user = build(:user, first_name_kana: "テストユーザテストユーザテストユーザテストユーザテストユーザテ")
#       user.valid?
#       expect(user.errors[:first_name_kana]).to include("は30文字以内で入力してください")
#     end

#     it "first_name_kanaがフォーマットに則っていない場合は登録できないこと（全角ひらがな）" do
#       user = build(:user, first_name_kana: "てすとゆーざ")
#       user.valid?
#       expect(user.errors[:first_name_kana]).to include("を正しく入力してください")
#     end

#     it "last_name_kanaがない場合は登録できないこと" do
#       user = build(:user, last_name_kana: nil)
#       user.valid?
#       expect(user.errors[:last_name_kana]).to include("を入力してください")
#     end

#     it "last_name_kanaが30文字より長い場合は登録できないこと" do
#       user = build(:user, last_name_kana: "テストユーザテストユーザテストユーザテストユーザテストユーザテ")
#       user.valid?
#       expect(user.errors[:last_name_kana]).to include("は30文字以内で入力してください")
#     end

#     it "last_name_kanaがフォーマットに則っていない場合は登録できないこと（半角英字）" do
#       user = build(:user, last_name_kana: "testuser")
#       user.valid?
#       expect(user.errors[:last_name_kana]).to include("を正しく入力してください")
#     end

#     it "introductionがない場合は登録できないこと" do
#       user = build(:user, introduction: nil)
#       user.valid?
#       expect(user.errors[:introduction]).to include("を入力してください")
#     end

#     it "introductionが300文字より長い場合は登録できないこと" do
#       user = build(:user, introduction: "テストユーザテストユーザテストユーザテストユーザテストユーザ"*10 + "テ")
#       user.valid?
#       expect(user.errors[:introduction]).to include("は300文字以内で入力してください")
#     end

#     it "birthdayがない場合は登録できないこと" do
#       user = build(:user, birthday: nil)
#       user.valid?
#       expect(user.errors[:birthday]).to include("を入力してください")
#     end

#     it "birthdayがフォーマットに則っていない場合は登録できないこと" do
#       user = build(:user, birthday: "1994/05/45")
#       user.valid?
#       expect(user.errors[:birthday]).to include("を正しく入力してください")
#     end

#     it "telephoneがない場合は登録できないこと" do
#       user = build(:user, telephone: nil)
#       user.valid?
#       expect(user.errors[:telephone]).to include("を入力してください")
#     end

#     it "telephoneが11文字より長い場合は登録できないこと" do
#       user = build(:user, telephone: "012345678912")
#       user.valid?
#       expect(user.errors[:telephone]).to include("は11文字以内で入力してください")
#     end

#     it "telephoneが10文字より短い場合は登録できないこと" do
#       user = build(:user, telephone: "012345678")
#       user.valid?
#       expect(user.errors[:telephone]).to include("は10文字以上で入力してください")
#     end

#     it "telephoneがフォーマットに則っていない場合は登録できないこと（半角英字）" do
#       user = build(:user, telephone: "testnumber")
#       user.valid?
#       expect(user.errors[:telephone]).to include("を正しく入力してください")
#     end

#     it "passwordが7文字より短い場合は登録できないこと" do
#       user = build(:user, password: "012345", password_confirmation: "012345")
#       user.valid?
#       expect(user.errors[:password]).to include("は7文字以上で入力してください")
#     end

#     it "passwordとpassword_confirmationが異なる場合は登録できないこと" do
#       user = build(:user, password_confirmation: "testuserr")
#       user.valid?
#       expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
#     end

#   end
# end