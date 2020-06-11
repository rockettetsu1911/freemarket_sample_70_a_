class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  has_one  :address,   dependent: :destroy
  has_many :comments
  has_many :items,     dependent: :destroy
  has_many :likes,     dependent: :destroy
  has_many :cards,     dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_ZENKAKU_REGEX = /\A[^\x01-\x7E]+\z/
  VALID_KANA_REGEX = /\A[\p{katakana}ー－&&[^ -~｡-ﾟ]]+\z/
  VALID_BIRTHDAY_REGEX = /\A(19|20)\d{2}\/([1-9]|0[1-9]|1[0-2])\/([1-9]|0[1-9]|[12][0-9]|3[01])\z/
  VALID_TELEPHONE_REGEX = /\d+/

  validates :email,           presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :first_name,      presence: true, length: { maximum: 15 }, format: {with: VALID_ZENKAKU_REGEX}
  validates :last_name,       presence: true, length: { maximum: 15 }, format: {with: VALID_ZENKAKU_REGEX}
  validates :first_name_kana, presence: true, length: { maximum: 30 }, format: {with: VALID_KANA_REGEX}
  validates :last_name_kana,  presence: true, length: { maximum: 30 }, format: {with: VALID_KANA_REGEX}
  validates :nickname,        presence: true, uniqueness: true, length: { maximum: 20 }
  validates :introduction,    presence: true, length: { maximum: 300 }
  validates :birthday,        presence: true, format: {with: VALID_BIRTHDAY_REGEX}
  validates :telephone,       presence: true, length: { in: 10..11 }, format: {with: VALID_TELEPHONE_REGEX}
  validates :password,        presence: true, confirmation: true, length: {minimum: 7}

end
