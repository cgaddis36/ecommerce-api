module Mutations
  module Users
    class Destroy < ::Mutations::BaseMutation
      argument :token, String, required: true

      field :user, Types::UserType, null: false
      field :errors, [String], null: false

      def resolve(token:)

        if decoded_token = JWT.decode(token, ENV['HMAC_SECRET'], true, { algorithm: 'HS256' })
          user_id = decoded_token[0]["user"]
          user = User.find(user_id)
          user = user.destroy!
          {
            user: user,
            errors: []
          }
        else
          {
            user: nil,
            errors: user.errors.full_messages
          }
        end
      end
    end
  end
end
