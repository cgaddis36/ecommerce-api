class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items 
  has_many :item_size_colors, :through => :cart_items 
end
