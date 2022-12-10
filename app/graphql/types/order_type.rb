# frozen_string_literal: true

module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :item_count, Integer
    field :total_weight, Float
    field :shipping_zip_code, String
    field :shipping_price, Float
    field :item_subtotal, Float
    field :tax, Float
    field :total, Float
    field :status, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
