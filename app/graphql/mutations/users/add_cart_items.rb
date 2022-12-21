module Mutations 
  module Users 
    class AddCartItems < Mutations::BaseMutation
      type Types::UserType, null: false 
      argument :user_id, String, required: true
      argument :item_size_color_id, String, required: true
      argument :quantity, String, required: true

      field :user, Types::UserType, null: false 
      field :errors, [String], null: false

      def resolve(
        user_id:, 
        item_size_color_id:, 
        quantity:
        )
        user = User.find(user_id)
        item = ItemSizeColor.find(item_size_color_id)

        if item.stock < quantity.to_i 
          {
            user: user,
            errors: ["Quantity selected exceeds Item stock."]
          }
        else 
          cart = user.cart 
          if !cart.nil? && cart_item = CartItem.find_by(cart_id: cart.id, item_size_color_id: item_size_color_id)
            new_quantity = cart_item.quantity += quantity.to_i
            cart_item.update!(quantity: new_quantity) 
          elsif !cart.nil?
            CartItem.create(
              cart_id: cart.id, 
              item_size_color_id: item.id,
              quantity: quantity
            )
          else 
            cart = Cart.create(
              user_id: user_id
            )
            CartItem.create(
              cart_id: cart.id, 
              item_size_color_id: item.id,
              quantity: quantity
            )
          end 
          user = User.find(user_id)
            {
              user: user,
              errors: []
            }
        end 
      end 
    end 
  end 
end