module Types
  class MutationType < Types::BaseObject
    field :add_cart_items, mutation: Mutations::Users::AddCartItems
    field :delete_cart_items, mutation: Mutations::Users::DeleteCartItems
    
    field :create_order, mutation: Mutations::Orders::CreateOrder
  end
end
