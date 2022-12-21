module Types
  class MutationType < Types::BaseObject
    field :add_items_to_cart, mutation: Mutations::Users::AddItemsToCart
  end
end
