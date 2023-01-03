require 'rails_helper'

RSpec.describe 'It removes the correct items from cart', type: :request do 
  before(:each) do 
    @user0 = create(:user)
    @user1 = create(:user)
    @user3 = create(:user)

    @category0 = create(:category, role: 0)
    @category1 = create(:category, role: 1)

    @item0 = create(:item, subcategory: 0, category_id: @category0.id)
    @item1 = create(:item, subcategory: 1, category_id: @category0.id)
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
    @cart0 = create(:cart, user: @user0)
    @cart_item0 = create(:cart_item, item_size_color: @item_size_color0, cart: @cart0, quantity: 2)
    @cart_item1 = create(:cart_item, item_size_color: @item_size_color1, cart: @cart0, quantity: 1)

    @cart1 = create(:cart, user: @user1)
    @cart_item2 = create(:cart_item, item_size_color: @item_size_color3, cart: @cart1, quantity: 2)
    @cart_item3 = create(:cart_item, item_size_color: @item_size_color4, cart: @cart1, quantity: 1)

    @cart2 = create(:cart, user: @user3)
    @cart_item4 = create(:cart_item, item_size_color: @item_size_color7, cart: @cart2, quantity: 1)
  end 
  it "Removes one quantity of a cart_item that has more than one in the cart" do
    quantity = 1
    cart_item_id = @cart_item0.id
    post "/graphql", params: {query: query_string(cart_item_id, quantity)}
    reply = JSON.parse(response.body, symbolize_names: true)

    data = reply[:data]
    request_data = data[:deleteCartItems]

    user = request_data[:user]
    cart = user[:cart]

    cart_items = cart[:cartItems]
    cart_item = cart_items.first
    expect(cart_item[:quantity]).to eq(1)
  end 
  it "Deletes the CartItem object if the quantity selected to delete is equal to the quantity currently in the user's cart." do 
    quantity = 2
    cart_item_id = @cart_item2.id
    post "/graphql", params: {query: query_string(cart_item_id, quantity)}
    reply = JSON.parse(response.body, symbolize_names: true)

    data = reply[:data]
    request_data = data[:deleteCartItems]

    user = request_data[:user]
    cart = user[:cart]

    cart_items = cart[:cartItems]
    expect(cart_items.count).to eq(1)
  end 
  it "CartItems are empty if the item removed is the last in the cart" do 
    quantity = 1
    cart_item_id = @cart_item4.id
    post "/graphql", params: {query: query_string(cart_item_id, quantity)}
    reply = JSON.parse(response.body, symbolize_names: true)

    data = reply[:data]
    request_data = data[:deleteCartItems]

    user = request_data[:user]
    cart = user[:cart]

    cart_items = cart[:cartItems]

    expect(cart_items).to be_empty
  end 
  def query_string(
    cart_item_id,
    quantity
  )
    <<~GQL 
      mutation {
        deleteCartItems(
          input: {
          cartItemId: "#{cart_item_id}",
          quantity: "#{quantity}" 
        }) {
          user {
            id 
            cart {
              id
              cartItems {
                id
                quantity
              }
            }
          }
        }
      }
    GQL
  end 
end 