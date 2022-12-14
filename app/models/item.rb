class Item < ApplicationRecord
  belongs_to :category
  has_many :item_size_colors
  has_many :sizes, :through => :item_size_colors
  has_many :colors, :through => :item_size_colors
end
