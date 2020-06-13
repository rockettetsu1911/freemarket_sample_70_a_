class Address < ApplicationRecord
  belongs_to :user, optional: true

  VALID_ZIP_CODE_REGEX = /\A\d{7}\z/
  # ハイフンなし、7桁
  validates :dest_first_name, :dest_last_name, :dest_first_name_kana, :dest_last_name_kana,
            :prefecture, :city, :block_number,  
            presence: true
  validates :zip_code, presence: true, format: { with: VALID_ZIP_CODE_REGEX }

  enum prefecture:{
    '---':         0,
    #東北地方
    hokkaido: 1, aomori: 2, iwate: 3,  miyagi: 4, akita: 5, yamagata: 6, fukushima: 7,

    #関東地方
    ibaraki: 8,  tochigi: 9, gunma: 10, saitama: 11, chiba: 12, tokyo: 13, kanagawa: 14,

    #東海地方
    nigata: 15, toyama: 16, ishikawa: 17, fukui: 18, yamanashi: 19, nagano: 20,
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
