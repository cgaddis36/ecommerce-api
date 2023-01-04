require 'rails_helper'

RSpec.describe 'Update User Password', type: :request do
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

    post "/graphql", params: { query: query_string(email, password, password_confirmation)}
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
    post '/graphql', params: { query: query_string1(email) }
    reply = JSON.parse(response.body, symbolize_names: true)
    expect(reply[:data][:requestUserPassword][:user][:id]).to eq(user_id)
  end
  def query_string(
    email,
    password,
    password_confirmation
  )
    <<~GQL
    mutation{
      createUser(input: {
        email: "#{email}",
        password: "#{password}",
        passwordConfirmation: "#{password}"
        firstName: "Max",
        lastName: "Cat"
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
  def query_string1(email)
    <<~GQL
    mutation{
      requestUserPassword(input: {
        email: "#{email}"
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
