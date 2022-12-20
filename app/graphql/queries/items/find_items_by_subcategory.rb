module Queries 
  module Items 
    class FindItemsBySubcategory < Queries::BaseQuery
      type [Types::ItemType], null: false
      argument :role, String, required: true
      argument :subcategory, String, required: true

      def resolve(role:, subcategory:)
        items = Category.where(role: role).first.items.where(subcategory: subcategory)       
        items
      end 
    end 
  end 
end 