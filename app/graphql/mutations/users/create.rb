module Mutations
  module Users
    class Create < ::Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(email:, password:, password_confirmation:, first_name:, last_name:)
        user = User.new(
          email: email,
          password: password,
          password_confirmation: password_confirmation,
          first_name: first_name,
          last_name: last_name
        )
        if user.save
          exp = Time.now.to_i + 4 * 3600
          exp_payload = { user: user.id, exp: exp }
          token = JWT.encode(exp_payload, ENV['HMAC_SECRET'], 'HS256')

          user.token = token
          id = user.id
          user.save
          url = ENV['DOMAIN'] + "/user/#{id}/activate"
          UserMailer.welcome(email, first_name, url).deliver_now
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
