require 'rails_helper'

RSpec.describe 'Update User', type: :request do
  before(:each) do
    @user0 = create(:user)
    @user1 = create(:user)
    @user2 = create(:user)

    Faker::UniqueGenerator.clear
  end
  it "Updates a user when passed the JSON web token from initial creation" do
    email = "ForeverRuby" + rand(1..9999).to_s + "@example.com"
    password = "hamburglar" + rand(1..9999).to_s
    password_confirmation = password
    first_name = "Charlie"
    last_name = "Barker"
    
    post "/graphql", params: { query: query_string(email, password, password_confirmation, first_name, last_name)}
    expect(response).to be_successful
    reply = JSON.parse(response.body, symbolize_names: true)

    token = reply[:data][:createUser][:user][:token]
    user_id = reply[:data][:createUser][:user][:id]
    first_name = "CharlieBoy"
    last_name = "BarleyBoy"
    phone = "(855) 123-2111"
    address1 = "123 Charlie St"
    address2 = "Unit 123"
    city = "Charlies Castle"
    state = "FL"
    zip_code = "12333"
    post '/graphql', params: { query: query_string1(token, first_name, last_name, address1, address2, city, state, phone, zip_code) }
    reply = JSON.parse(response.body, symbolize_names: true)
    expect(reply[:data][:updateUser][:user][:id]).to eq(user_id)
  end
  def query_string(
    email,
    password,
    password_confirmation,
    first_name,
    last_name
    )
    <<~GQL
    mutation{
      createUser(
        input: {
        email: "#{email}",
        password: "#{password}",
        passwordConfirmation: "#{password_confirmation}",
        firstName: "#{first_name}",
        lastName: "#{last_name}"
      }
      ) {
        user {
          id
          token
          email
        }
    }
     }
     GQL
  end
  def query_string1(token, first_name, last_name, address1, address2, city, state, phone, zip_code)
    <<~GQL
    mutation{
      updateUser(input: {
        token: "#{token}",
        firstName: "#{first_name}",
        lastName: "#{last_name}",
        city: "#{city}",
        state: "#{state}",
        zipCode: "#{zip_code}"
      }) {
        user { 
          id
          firstName
          lastName
          email
          city
          state
          zipCode
          }
      }
     }
     GQL
  end
end
