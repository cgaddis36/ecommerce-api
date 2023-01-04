class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_many :orders 
  has_one :cart
  enum role: {
    member: 0,
    admin: 1
  }
  has_secure_password
  has_secure_token
end
