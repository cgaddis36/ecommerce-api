require 'rails_helper'

RSpec.describe '', type: :request do 
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
  end 
  it "Adds an item and its quantity to the User's Cart" do 

    user_id = @user0.id
    item_size_color_id = @item_size_color1.id 
    quantity = 2
    post "/graphql", params: {
      query: query_string(
        user_id, 
        item_size_color_id, 
        quantity
    )}
    reply = JSON.parse(response.body, symbolize_names: true)

    data = reply[:data]
    request_data = data[:addCartItems]
    user = request_data[:user]
    expect(user).to_not be_empty
    expect(user[:id].to_i).to eq(user_id)
    cart = user[:cart]
    cartItems = cart[:cartItems]
    expect(cartItems.count).to eq(1)
    cartItem = cartItems[0]
    expect(cartItem[:quantity]).to eq(quantity)
  end 
  it "Adds a new cart_item and its quantity to the User's Cart when there is already an existing cart with other items in it." do 
    user_cart = create(:cart, user: @user1)
    cart_item = create(:cart_item, cart: user_cart, item_size_color: @item_size_color0, quantity: 2)

    user_id = @user1.id
    item_size_color_id = @item_size_color3.id 
    quantity = 2
    post "/graphql", params: {
      query: query_string(
        user_id, 
        item_size_color_id, 
        quantity
    )}
    reply = JSON.parse(response.body, symbolize_names: true)
    data = reply[:data]
    request_data = data[:addCartItems]
    user = request_data[:user]


    cart = user[:cart]
    cartItems = cart[:cartItems]
    expect(cartItems.count).to eq(2)
    cartItem = cartItems[0]
    expect(cartItem[:quantity]).to eq(2)
    cartItem0 = cartItems[1]
    expect(cartItem[:quantity]).to eq(2)
  end 
  it "Adds a new quantity to a cart_item that is already in the users cart" do 
    user_cart = create(:cart, user: @user3)
    cart_item0 = create(:cart_item, cart: user_cart, item_size_color: @item_size_color3, quantity: 2)
    cart_item1 = create(:cart_item, cart: user_cart, item_size_color: @item_size_color0, quantity: 2)

    user_id = @user3.id
    item_size_color_id = @item_size_color3.id 
    quantity = 2
    post "/graphql", params: {
      query: query_string(
        user_id, 
        item_size_color_id, 
        quantity
    )}
    reply = JSON.parse(response.body, symbolize_names: true)
    data = reply[:data]
    request_data = data[:addCartItems]
    user = request_data[:user]

    cart = user[:cart]
    cart_items = cart[:cartItems]
    expect(cart_items.count).to eq(2)

    updated_cart_item = cart_items[1]
    expect(updated_cart_item[:quantity]).to eq(4)
  end 
  def query_string(
    user_id,
    item_size_color_id,
    quantity
    )
    <<~GQL 
      mutation {
        addCartItems(input: {
          userId: "#{user_id}",
          itemSizeColorId: "#{item_size_color_id}",
          quantity: "#{quantity}"}
        ) {
          user{ 
            id
            firstName
            lastName 
            cart {
              id
              cartItems {
                id
                quantity
                itemSizeColor {
                  id
                  stock
                  item {
                    id
                    name 
                    price
                  }
                  color {
                    id
                    name 
                  }
                  size {
                    id 
                    name
                  }
                }
              }
            }
          }
        }
      }
    GQL
  end 
end 