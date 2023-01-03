module Mutations 
  module Orders 
    class CreateOrder < Mutations::BaseMutation 
      type Types::OrderType, null: false 
      argument :cart_id, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :address1, String, required: true
      argument :address2, String, required: true
      argument :city, String, required: true
      argument :state, String, required: true
      argument :zip_code, String, required: true


      field :order, Types::OrderType, null: true 
      field :errors, [String], null: false 
      def resolve(
        cart_id:, 
        first_name:,
        last_name:,
        address1:,
        address2:,
        city:,
        state:,
        zip_code:
        )
        cart = Cart.find(cart_id)

        user = cart.user
        user_id = user.id
        shipping_price = cart.estimated_shipping
        tax = cart.tax 
        total = cart.total 

        order = Order.create(
          user_id: user_id,
          shipping_first_name: first_name, 
          shipping_last_name: last_name,
          shipping_address1: address1,
          shipping_address2: address2,
          shipping_city: city,
          shipping_state: state,
          shipping_zip_code: zip_code,
          shipping_price: shipping_price,
          tax: tax,
          total: total
          )

        cart_items = cart.cart_items 

        cart_items.each do |cart_item|
          if cart_item.quantity > cart_item.item_size_color.stock
            order.delete!
            {
              order: nil,
              errors: ["Another customer checked out with your goods before you were able to complete your order."]
            }
          else 
            nil
          end  
        end 

        cart_items.each do |cart_item|
          item_size_color_id = cart_item.item_size_color_id
          item_size_color = ItemSizeColor.find(item_size_color_id)
          OrderItem.create(
            order_id: order.id,
            item_size_color_id: item_size_color_id,
            quantity: cart_item.quantity
          )

          current_stock = item_size_color.stock
          new_stock = current_stock - cart_item.quantity
          item_size_color.update(stock: new_stock)
          cart_item.delete
        end 
        
        cart.destroy
        {
          order: order,
          errors: []
        }
      end 
    end 
  end 
end