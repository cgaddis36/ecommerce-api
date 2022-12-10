module Queries 
  module Items 
    class FindItem < Queries::BaseQuery
      type Types::ItemType, null: false
      argument :id, String, required: true

      def resolve(id:)
        item = Item.find(id)
        item
      end 
    end 
  end 
end 