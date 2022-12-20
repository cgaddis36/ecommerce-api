class Item < ApplicationRecord
  belongs_to :category
  has_many :item_size_colors
  has_many :sizes, :through => :item_size_colors
  has_many :colors, :through => :item_size_colors
  enum subcategory: {
    shirts: 0,
    hats: 1,
    hoodies: 2,
    signs: 3,
    coasters: 4
  }
end
