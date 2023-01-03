require 'rails_helper'

RSpec.describe 'Find Items by role attribute', type: :request do 
  before(:each) do 
    @category0 = create(:category, role: 0)
    @category1 = create(:category, role: 1)
    @item0 = create(:item, subcategory: 0, category_id: @category0.id)
    @item1 = create(:item, subcategory: 1, category_id: @category0.id)
    @item2 = create(:item, subcategory: 1, category_id: @category0.id)
    @item3 = create(:item, subcategory: 0, category_id: @category0.id)
    @item4 = create(:item, subcategory: 2, category_id: @category0.id)

    @item5 = create(:item, subcategory: 4, category_id: @category1.id)
    @item6 = create(:item, subcategory: 3, category_id: @category1.id)
    @item7 = create(:item, subcategory: 3, category_id: @category1.id)
    @item8 = create(:item, subcategory: 3, category_id: @category1.id)
  end 
  it 'returns all items with that role classification' do 
    role = @item2.category.role
    subcategory = @item2.subcategory

    post '/graphql', params: {query: query_string(role, subcategory)}

    reply = JSON.parse(response.body, symbolize_names: true)
    data = reply[:data]

    items = data[:findItemsBySubcategory]
    expect(items.count).to eq(2)
  end 
  def query_string(role, subcategory)
      <<~GQL
        query {
          findItemsBySubcategory(
            role: "#{role}",
            subcategory: "#{subcategory}"
          ) {
            id 
            name 
            description 
            price 
            discount 
            category {
              id 
              title 
              role 
            }
          }

        }
      GQL
    end
end