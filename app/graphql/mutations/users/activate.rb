module Mutations
  module Users
    class Activate < ::Mutations::BaseMutation
      argument :id, String, required: true

      field :user, Types::UserType, null: false
      field :errors, [String], null: false

      def resolve(id:)
        if user = User.find(id)
          user.update(
            active: true
          )

          if user.save
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
