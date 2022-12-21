class User < ApplicationRecord
  has_many :orders 
  has_one :cart
  enum role: {
    member: 0,
    admin: 1
  }
end
