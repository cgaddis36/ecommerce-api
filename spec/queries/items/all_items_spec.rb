require 'rails_helper'

RSpec.describe "It fetches all items in the database", type: :request do 
  before(:each) do 
    @category0 = create(:category)
    @category1 = create(:category)

    @item0 = create(:item, category: @category0)
    @item1 = create(:item, category: @category0)
    @item2 = create(:item, category: @category0)
    @item3 = create(:item, category: @category0)

    @item4 = create(:item, category: @category1)
    @item5 = create(:item, category: @category1)
    @item6 = create(:item, category: @category1)
    @item7 = create(:item, category: @category1)
  end 
  it "successfully completes the query" do 
    post "/graphql", params: {
      query: query_string
    }
    reply = JSON.parse(response.body, symbolize_names: true)

    items_data = reply[:data][:allItems]
    expect(items_data.count).to eq(8)
  end 
  def query_string 
    <<~GQL 
    query {
      allItems {
        name 
        price 
        discount 
        description
        category {
          role 
          title
        }
      }
    }
    GQL
  end 
end 
