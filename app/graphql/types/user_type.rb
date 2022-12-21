# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :role, Integer
    field :first_name, String
    field :last_name, String
    field :email, String
    field :password_digest, String
    field :address1, String
    field :address2, String
    field :city, String
    field :state, String
    field :zip_code, String
    field :phone, String
    field :cart, Types::CartType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
