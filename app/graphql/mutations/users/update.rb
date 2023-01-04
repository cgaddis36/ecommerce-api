module Mutations
  module Users
    class Update < ::Mutations::BaseMutation
      argument :token, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :city, String, required: true
      argument :state, String, required: true
      argument :zip_code, String, required: true

      field :user, Types::UserType, null: false
      field :token, String, null: false
      field :errors, [String], null: false

      def resolve(token:, first_name:, last_name:, city:, state:, zip_code:)

        if decoded_token = JWT.decode(token, ENV['HMAC_SECRET'], true, { algorithm: 'HS256' })
          user_id = decoded_token[0]["user"]
          user = User.find(user_id)
          user.update(
            first_name: first_name,
            last_name: last_name,
            city: city,
            state: state,
            zip_code: zip_code
          )

          if user.save
            {
              user: user,
              token: token,
              errors: []
            }
          else
            {
              user: nil,
              token: token,
              errors: user.errors.full_messages
            }
          end
        else
          {
            user: nil,
            token: "JWT Expired",
            errors: user.errors.full_messages
          }
        end
      end
    end
  end
end
