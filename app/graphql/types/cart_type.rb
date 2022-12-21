# frozen_string_literal: true

module Types
  class CartType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :item_count, Integer
    field :total_weight, Float
    field :shipping_zip_code, String
    field :estimated_shipping, Float
    field :item_subtotal, Float
    field :discount, Float
    field :tax, Float
    field :total, Float
    field :cart_items, [Types::CartItemType]
    field :user, Types::UserType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
