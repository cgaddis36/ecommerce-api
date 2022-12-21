# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :description, String
    field :stock, Integer
    field :price, Float
    field :discount, Float
    field :images, String
    field :color, String
    field :material, String
    field :category, Types::CategoryType
    field :category_id, Integer, null: false
    field :item_size_colors, [Types::ItemSizeColorType]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
