module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :all_items, resolver: Queries::Items::AllItems
    field :find_item, resolver: Queries::Items::FindItem
    field :find_items, resolver: Queries::Items::FindItems
    field :find_items_by_subcategory, resolver: Queries::Items::FindItemsBySubcategory
  end
end
