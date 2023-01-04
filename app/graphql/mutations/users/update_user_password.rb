module Mutations
  module Users
    class UpdateUserPassword < ::Mutations::BaseMutation
      argument :user_id, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: false
      field :token, String, null: false
      field :errors, [String], null: false

      def resolve(user_id:, password:)

        if user = User.find(user_id)

          exp = Time.now.to_i + 4 * 3600
          exp_payload = { user: user.id, exp: exp }

          token = JWT.encode(exp_payload, ENV['HMAC_SECRET'], 'HS256')

          user.token = token
          user.update(
            password_digest: password
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
            token: "User not found",
            errors: user.errors.full_messages
          }
        end
      end
    end
  end
end
