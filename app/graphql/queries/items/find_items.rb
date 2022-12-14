module Queries 
  module Items 
    class FindItems < Queries::BaseQuery
      type [Types::ItemType], null: false
      argument :role, String, required: true

      def resolve(role:)
        items = Category.where(role: role).first.items        
        items
      end 
    end 
  end 
end 