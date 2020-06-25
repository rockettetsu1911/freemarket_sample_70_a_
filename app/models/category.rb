class Category < ApplicationRecord

  has_many :items
  has_ancestry

  validates :name, presence: { message: "カテゴリーを選択してください" }

  #enum name:{
    #'---':                 0,
    #ladies:                1, 
    #mens:                  2, 
    #baby_and_kids:         3,
    #interior:              4, 
    #sub_culture:           5, 
    #hobby:                 6,
    #cosme:                 7,
    #electrical_appliances: 8,
    #sports:                9,
    #handmade:              10,
    #ticket:                11,
    #bicycle:               12,
    #etc:                   13
  #}
end
