module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :all_items, resolver: Queries::Items::AllItems
    field :find_item, resolver: Queries::Items::FindItem
  end
end
