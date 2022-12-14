class ItemSizeColor < ApplicationRecord
  has_many :order_items
  has_many :orders, :through => :order_items
  has_many :cart_items
  has_many :carts, :through => :cart_items
  belongs_to :item
  belongs_to :size
  belongs_to :color
end
