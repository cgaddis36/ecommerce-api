module Mutations
  module Users
    class LoginUser < ::Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(email:, password:)

        if (user = User.find_by(email: email)) && user.authenticate(password)
          exp = Time.now.to_i + 4 * 3600
          exp_payload = { user: user.id, exp: exp }

          token = JWT.encode(exp_payload, ENV['HMAC_SECRET'], 'HS256')

          user.token = token
          {
            user: user,
            errors: []
          }
        else
          {
            user: nil,
            errors: ["Login information invalid."]
          }
        end
      end
    end
  end
end
