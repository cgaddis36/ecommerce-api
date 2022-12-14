class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items 
  has_many :item_size_colors, :through => :order_items
  enum status: {
    placed: 0,
    shipped: 1,
    delivered: 2,
    inquiry: 3, 
    refunded: 4,
    returned_and_refunded: 5,
    canceled: 6
  }
end
