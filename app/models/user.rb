class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one  :address,   dependent: :destroy
  has_many :comments
  has_many :items,     dependent: :destroy
  has_many :likes,     dependent: :destroy
  has_many :cards,     dependent: :destroy
       
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
         validates :email, format: { with: VALID_EMAIL_REGEX }
       
  VALID_TELEPHONE_REGEX = /\A\d{10}\z|\A\d{11}\z/
  # 10桁＋11桁、ハイフンなし
  validates :telephone, format: { with: VALID_TELEPHONE_REGEX}
       
       
  validates :password, :email, :first_name, :last_name,:first_name_kana, :last_name_kana, 
            :nickname, :introduction, :birthday, :telephone,
            presence: true
       
  validates :nickname, :email, uniqueness: true
       
  validates :password,        presence: { message: "パスワードを入力してください" }
  validates :email,           presence: { message: "メールアドレスを入力してください" }
  validates :first_name,      presence: { message: "苗字を入力してください" }
  validates :last_name,       presence: { message: "名前を入力してください" }
  validates :first_name_kana, presence: { message: "苗字の読み仮名を入力してください" }
  validates :last_name_kana,  presence: { message: "名前の読み仮名を入力してください" }
  validates :nickname,        presence: { message: "ニックネームを入力してください" }
  validates :introduction,    presence: { message: "自己紹介を入力してください" }
  validates :birthday,        presence: { message: "誕生日を入力してください" }
  validates :telephone,       presence: { message: "電話番号を入力してください" }
end
