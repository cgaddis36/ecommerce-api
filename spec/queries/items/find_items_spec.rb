require 'rails_helper'

RSpec.describe 'Find Items by role attribute', type: :request do 
  before(:each) do 
    @category0 = create(:category, role: 0)
    @category1 = create(:category, role: 1)
    @item0 = create(:item, category_id: @category0.id)
    @item1 = create(:item, category_id: @category0.id)
    @item2 = create(:item, category_id: @category0.id)
    @item3 = create(:item, category_id: @category0.id)
    @item4 = create(:item, category_id: @category0.id)

    @item5 = create(:item, category_id: @category1.id)
    @item6 = create(:item, category_id: @category1.id)
    @item7 = create(:item, category_id: @category1.id)
    @item8 = create(:item, category_id: @category1.id)
  end 
  it 'returns all items with that role classification' do 
    post '/graphql', params: {query: query_string('softgoods')}

    reply = JSON.parse(response.body, symbolize_names: true)
    data = reply[:data]

    items = data[:findItems]
    expect(items.count).to eq(5)
  end 
  def query_string(role)
      <<~GQL
        query {
          findItems(role: "#{role}") {
            id 
            name 
            description 
            stock 
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