class DeliveryDate < ActiveHash::Base
  self.data = [
      {id: 1, name: '1〜2日で発送'}, {id: 2, name: '3〜4で発送'}
  ]
end