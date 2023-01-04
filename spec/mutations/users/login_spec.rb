require 'rails_helper'

RSpec.describe 'Login User', type: :request do
  before(:each) do
    @user0 = User.create(
      email: "NemosDad@example.com", 
      password: "FindDory123",
      password_confirmation: "FindDory123",
      first_name: "Marlin",
      last_name: "Clowney"
    )
    @user1 = User.create(
      email: "Dory@example.com", 
      password: "FindDory123",
      password_confirmation: "FindDory123",
      first_name: "Dory",
      last_name: "Blue-Tang"
    )
    @user2 = User.create(
      email: "Nemo@example.com", 
      password: "FindMe123",
      password_confirmation: "FindMe123",
      first_name: "Nemo",
      last_name: "Clowney"
    )

    Faker::UniqueGenerator.clear
  end
  it "Logins in a user when passed the proper password and email" do
    email = @user0.email

    password = "FindDory123"

    post "/graphql", params: { query: query_string(email, password)}
    expect(response).to be_successful
    reply = JSON.parse(response.body, symbolize_names: true)

    user_data = reply[:data][:loginUser][:user]
    expect(user_data[:id]).to eq(@user0.id.to_s)
  end
 
  def query_string(email, password)
    <<~GQL
    mutation{
      loginUser(input: {
        email: "#{email}",
        password: "#{password}"}
      ) { 
        user {
          id
          token
        }
      errors
      }
     }
     GQL
  end
end
