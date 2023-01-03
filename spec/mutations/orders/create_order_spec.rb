require 'rails_helper'

RSpec.describe "It creates an Order", type: :request do 
  before(:each) do 
    @user0 = create(:user)
    @user1 = create(:user)
    @user3 = create(:user)

    @category0 = create(:category, role: 0)
    @category1 = create(:category, role: 1)

    @item0 = create(:item, price: 25.00, subcategory: 0, category_id: @category0.id)
    @item1 = create(:item, price: 30.00, subcategory: 1, category_id: @category0.id)
    @item2 = create(:item, subcategory: 1, category_id: @category0.id)
    @item3 = create(:item, subcategory: 0, category_id: @category0.id)
    @item4 = create(:item, subcategory: 2, category_id: @category0.id)

    @item5 = create(:item, subcategory: 4, category_id: @category1.id)
    @item6 = create(:item, subcategory: 3, category_id: @category1.id)
    @item7 = create(:item, subcategory: 3, category_id: @category1.id)
    @item8 = create(:item, subcategory: 3, category_id: @category1.id)

    @size0 = create(:size)
    @size1 = create(:size)
    @size2 = create(:size)
    @size3 = create(:size)

    @color0 = create(:color)
    @color1 = create(:color)
    @color2 = create(:color)
    @color3 = create(:color)

    @item_size_color0 = create(
      :item_size_color, 
      item: @item0, 
      size: @size0, 
      color: @color0, 
      stock: 5
      )
    @item_size_color1 = create(
      :item_size_color, 
      item: @item0, 
      size: @size1, 
      color: @color0, 
      stock: 5
      )
    @item_size_color2 = create(
      :item_size_color, 
      item: @item0, 
      size: @size2, 
      color: @color0, 
      stock: 5
      )
    @item_size_color3 = create(
      :item_size_color, 
      item: @item0, 
      size: @size3, 
      color: @color0, 
      stock: 5
      )
    @item_size_color4 = create(
      :item_size_color, 
      item: @item1, 
      size: @size0, 
      color: @color1, 
      stock: 3
      )
    @item_size_color5 = create(
      :item_size_color, 
      item: @item1, 
      size: @size1, 
      color: @color1, 
      stock: 3
      )

    @item_size_color6 = create(
      :item_size_color, 
      item: @item1, 
      size: @size2, 
      color: @color2, 
      stock: 3
      )
    @item_size_color7 = create(
      :item_size_color, 
      item: @item1, 
      size: @size3, 
      color: @color3, 
      stock: 3
      )
    @cart0 = create(:cart, user: @user0, shipping_zip_code: "75281", estimated_shipping: "5.00", discount: 0.00, tax: 7.00)
    
    @cart_item0 = create(:cart_item, item_size_color: @item_size_color0, cart: @cart0, quantity: 2)
    @cart_item1 = create(:cart_item, item_size_color: @item_size_color1, cart: @cart0, quantity: 1)
    @cart0.update_total
    @cart1 = create(:cart, user: @user1)
    @cart_item2 = create(:cart_item, item_size_color: @item_size_color3, cart: @cart1, quantity: 2)
    @cart_item3 = create(:cart_item, item_size_color: @item_size_color4, cart: @cart1, quantity: 1)

    @cart2 = create(:cart, user: @user3)
    @cart_item4 = create(:cart_item, item_size_color: @item_size_color7, cart: @cart2, quantity: 1)
  end 
  it "Creates an order from a cart that has all of the proper items to place an order" do
    cart_id = @cart0.id
    first_name = "First"
    last_name = "Name"
    address1 = "123 Address St"
    address2 = "Unit 123"
    city = "Green Bay"
    state = "Wisconsin"
    zip_code = "54308"

    post '/graphql', params: {query: query_string(
      cart_id,
      first_name,
      last_name,
      address1,
      address2,
      city,
      state,
      zip_code
      )}

    reply = JSON.parse(response.body, symbolize_names: true)
    data = reply[:data]
    request_data = data[:createOrder]

    order = request_data[:order]
    
    expect(order).to_not be_empty
    expect(order[:status]).to eq(0)
    expect(order[:orderItems].count).to eq(2)
  end 


  def query_string(
    cart_id,
    first_name,
    last_name,
    address1,
    address2,
    city,
    state,
    zip_code
    )
    <<~GQL 
      mutation {
        createOrder(input: {
          cartId: "#{cart_id}",
          firstName: "#{first_name}",
          lastName: "#{last_name}",
          address1: "#{address1}",
          address2: "#{address2}",
          city: "#{city}",
          state: "#{state}",
          zipCode: "#{zip_code}"
        }) {
          order {
            id 
            status
            orderItems {
              id
              quantity
              itemSizeColor {
              stock
              }
            }
          }
        }
      }
    GQL
  end 
end 