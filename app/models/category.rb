class Category < ApplicationRecord
  has_many :items
  enum role: {
    softgoods: 0,
    hardgoods: 1
  }
end
