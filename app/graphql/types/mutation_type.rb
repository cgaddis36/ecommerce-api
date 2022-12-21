module Types
  class MutationType < Types::BaseObject
    field :add_cart_items, mutation: Mutations::Users::AddCartItems
    field :delete_cart_items, mutation: Mutations::Users::DeleteCartItems
  end
end
