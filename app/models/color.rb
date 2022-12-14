class Color < ApplicationRecord
  has_many :item_size_colors
  has_many :items, :through => :item_size_colors
  has_many :sizes, :through => :item_size_colors
end
