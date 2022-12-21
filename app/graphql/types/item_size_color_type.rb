# frozen_string_literal: true

module Types
  class ItemSizeColorType < Types::BaseObject
    field :id, ID, null: false
    field :item_id, Integer, null: false
    field :size_id, Integer, null: false
    field :color_id, Integer, null: false
    field :stock, Integer
    field :item, Types::ItemType 
    field :size, Types::SizeType 
    field :color, Types::ColorType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
