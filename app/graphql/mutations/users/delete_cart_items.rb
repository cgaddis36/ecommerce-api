module Mutations 
  module Users 
    class DeleteCartItems < Mutations::BaseMutation
      type Types::UserType, null: false
      argument :cart_item_id, String, required: true
      argument :quantity, String, required: true 

      field :user, Types::UserType, null: false
      field :errors, [String], null: false
      
      def resolve(cart_item_id:, quantity:)
        cart_item = CartItem.find(cart_item_id)
        if cart_item.quantity == quantity.to_i
          cart_item.delete! 
        else 
          new_quantity = cart_item.quantity -= quantity.to_i
          updated_cart_item = cart_item.update(quantity: new_quantity)
        end 
        user = User.find(cart_item.cart.user_id)
        {
          user: user,
          errors: []
        }
      end
    end 
  end 
end 