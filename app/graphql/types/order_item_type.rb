# frozen_string_literal: true

module Types
  class OrderItemType < Types::BaseObject
    field :id, ID, null: false
    field :order_id, Integer, null: false
    field :item_id, Integer, null: false
    field :quantity, Integer
    field :price, Float
    field :discount, Float
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
