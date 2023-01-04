module Mutations
  module Users
    class RequestUserPassword < ::Mutations::BaseMutation
      argument :email, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(email:)
        if user = User.find_by(email: email)
          exp = Time.now.to_i + 4 * 3600
          exp_payload = { user: user.id, exp: exp }

          token = JWT.encode(exp_payload, ENV['HMAC_SECRET'], 'HS256')

          user.token = token
          user_id = user.id
          url = ENV['DOMAIN'] + "/profile/edit/password/" + user_id.to_s
          UserMailer.password_request(email, url).deliver_now

          {
            user: user,
            errors: []
          }
        else
          {
            user: nil,
            errors: ["Email not in our system. Try making another account"]
          }
        end
      end
    end
  end
end
