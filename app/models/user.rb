class User < ApplicationRecord
  has_many :orders 
  enum role: {
    guest: 0,
    member: 1,
    admin: 2
  }
end
