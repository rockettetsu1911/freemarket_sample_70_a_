class Address < ApplicationRecord
  belongs_to :user, optional: true

  #全角のみ
  VALID_ZENKAKU_REGEX = /\A[^\x01-\x7E]+\z/
  #全角カナのみ
  VALID_KANA_REGEX = /\A[\p{katakana}ー－&&[^ -~｡-ﾟ]]+\z/
  #郵便番号 ハイフンなし、7桁
  VALID_ZIP_CODE_REGEX = /\A\d{7}\z/
  #都道府県 アルファベットのみ
  VALID_PREFECTURE_REGEX = /[a-z+]/
  #数字のみ
  VALID_TELEPHONE_REGEX = /\d+/

  validates :dest_first_name,         presence: true, length: { maximum: 15 }, format: { with: VALID_ZENKAKU_REGEX }
  validates :dest_last_name,          presence: true, length: { maximum: 15 }, format: { with: VALID_ZENKAKU_REGEX }
  validates :dest_first_name_kana,    presence: true, length: { maximum: 30 }, format: { with: VALID_KANA_REGEX }
  validates :dest_last_name_kana,     presence: true, length: { maximum: 30 }, format: { with: VALID_KANA_REGEX }
  validates :zip_code,                presence: true, format: { with: VALID_ZIP_CODE_REGEX }
  validates :prefecture,              presence: true, format: { with: VALID_PREFECTURE_REGEX }
  validates :city,                    presence: true, length: { maximum: 30 }, format: { with: VALID_ZENKAKU_REGEX }
  validates :block_number,            presence: true, length: { maximum: 30 }, format: { with: VALID_ZENKAKU_REGEX }
  validates :building,                allow_blank: true, length: { maximum: 30 }, format: { with: VALID_ZENKAKU_REGEX }
  validates :telephone,               allow_blank: true, length: { in: 10..11 }, format: { with: VALID_TELEPHONE_REGEX }

  enum prefecture:{
    '---':         0,
    #東北地方
    hokkaido: 1, aomori: 2, iwate: 3,  miyagi: 4, akita: 5, yamagata: 6, fukushima: 7,

    #関東地方
    ibaraki: 8,  tochigi: 9, gunma: 10, saitama: 11, chiba: 12, tokyo: 13, kanagawa: 14,

    #東海地方
    niigata: 15, toyama: 16, ishikawa: 17, fukui: 18, yamanashi: 19, nagano: 20,
    gifu: 21, shizuoka: 22, aichi: 23,

    #近畿地方
    mie: 24, shiga: 25, kyoto: 26, osaka: 27, hyogo: 28, nara: 29, wakayama: 30,

    #中国地方
    tottori: 31, shimane: 32, okayama: 33, hiroshima: 34, yamaguchi: 35,

    #四国地方
    tokushima: 36, kagawa: 37, ehime: 38, kochi: 39,

    #九州地方
    fukuoka: 40, saga: 41, nagasaki: 42, kumamoto: 43, oita: 44,
    miyazaki: 45, kagoshima: 46, okinawa: 47
  }
end
