class Address < ApplicationRecord
  belongs_to :user, optional: true

  VALID_ZIP_CODE_REGEX = /\A\d{7}\z/
  # ハイフンなし、7桁
  validates :dest_first_name, :dest_last_name, :dest_first_name_kana, :dest_last_name_kana,
            :zip_code, :prefecture, :city, :block_number,  
            presence: true
  validates :zip_code, format: { with: VALID_ZIP_CODE_REGEX }

  enum prefecture:{
    '---':         0,
    #東北地方
    hokkaido: 1, aomori: 2, iwate: 3,  miyagi: 4, akita: 5, fukushima: 6,

    #関東地方
    ibaraki: 7,  tochigi: 8, gunma: 9, saitama: 10, chiba: 11, tokyo: 12, kanagawa: 13,

    #東海地方
    nigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano:   19,
    gifu:   20, shizuoka:   21, aichi: 22,

    #近畿地方
    mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27, nara: 28, wakayama: 29,

    #中国地方
    tottori: 30, shimane: 31, okayama: 32, hiroshima: 33, yamaguchi: 34,

    #四国地方
    tokushima: 35, kagawa: 36, ehime: 37, kochi: 38,

    #九州地方
    fukuoka: 39, saga: 40, nagasaki: 41, kumamoto: 42, oita: 43,
    miyazaki: 44, kagoshima: 45, okinawa:  46
  }
end
