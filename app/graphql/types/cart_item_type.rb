# frozen_string_literal: true

module Types
  class CartItemType < Types::BaseObject
    field :id, ID, null: false
    field :cart_id, Integer, null: false
    field :item_size_color_id, Integer, null: false
    field :quantity, Integer
    field :item_size_color, Types::ItemSizeColorType
    field :cart, Types::CartType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
