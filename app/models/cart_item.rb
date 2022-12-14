class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item_size_color
end
