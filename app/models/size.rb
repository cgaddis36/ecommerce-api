class Size < ApplicationRecord
  has_many :item_size_colors
  has_many :items, :through => :item_size_colors
  has_many :colors, :through => :item_size_colors
end
