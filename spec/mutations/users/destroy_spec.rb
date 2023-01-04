require 'rails_helper'

RSpec.describe 'Destroy User', type: :request do
  before(:each) do
    @user0 = create(:user)
    @user1 = create(:user)
    @user2 = create(:user)

    Faker::UniqueGenerator.clear
  end
  it "Destroys a user when passed the user's token" do
    email = "ForeverRuby" + rand(1..9999).to_s + "@example.com"
    password = "hamburglar" + rand(1..9999).to_s

    first_name = "First"
    last_name = "Name"
    
    post "/graphql", params: { query: query_string(email, password, first_name, last_name)}
    expect(response).to be_successful
    reply = JSON.parse(response.body, symbolize_names: true)

    token = reply[:data][:createUser][:user][:token]

    post "/graphql", params: { query: query_string1(token)}
    expect(response).to be_successful
    reply = JSON.parse(response.body, symbolize_names: true)
    data = reply[:data][:destroyUser]
    expect(data[:user][:email]).to eq(email)
  end
  def query_string(
    email,
    password,
    first_name,
    last_name
  )
    <<~GQL
    mutation {
      createUser(input: {
        email: "#{email}",
        password: "#{password}",
        passwordConfirmation: "#{password}",
        firstName: "#{first_name}",
        lastName: "#{last_name}"
        }
      ) {
        user {
          email
          token
        }
      }
     }
     GQL
  end
  def query_string1(token)
    <<~GQL
    mutation{
      destroyUser(input: {
        token: "#{token}"
      }){user{
        id
        email
        }}
     }
     GQL
  end
end
