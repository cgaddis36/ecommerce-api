class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items 
  has_many :item_size_colors, :through => :cart_items 

  def update_total
    total = 0.00
    cart_items = self.cart_items 
    cart_items.each do |cart_item| 
      item_subtotal = cart_item.item_size_color.item.price * cart_item.quantity 
      total += item_subtotal
    end 
    self.update(total: total)
  end 
end
