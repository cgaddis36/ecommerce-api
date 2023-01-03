require 'rails_helper'

RSpec.describe 'Find Item by id', type: :request do 
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
  it "returns the correct Item" do 
    id = @item2.id
    post "/graphql", params: {query: query_string(id)}
    reply = JSON.parse(response.body, symbolize_names: true)

    item_data = reply[:data]
    expect(item_data[:findItem][:name]).to eq(@item2.name)
  end 

  def query_string(id)
    <<~GQL 
      query {
        findItem(id: "#{id}") {
          id 
          name 
          description
          price 
          discount
          category {
            title 
            role
          }
        }
      }
      GQL
    end 
end 