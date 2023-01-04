require 'rails_helper'

RSpec.describe 'Create User', type: :request do
  before(:each) do
    @user0 = create(:user)
    @user1 = create(:user)
    @user2 = create(:user)

    Faker::UniqueGenerator.clear
  end
  it "Creates a user when passed the proper password and email" do
    email = "ForeverRuby" + rand(1..9999).to_s + "@example.com"
    password = "hamburglar" + rand(1..9999).to_s
    
    first_name = "First"
    last_name = "Name"

    post "/graphql", params: { query: query_string(email, password, first_name, last_name)}
    expect(response).to be_successful
    reply = JSON.parse(response.body, symbolize_names: true)

    user_data = reply[:data][:createUser]
    expect(user_data[:user][:token]).to_not be_nil

    expect(User.all.count).to eq(4)
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
end
