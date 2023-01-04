module Types
  class MutationType < Types::BaseObject
    field :login_user, mutation: Mutations::Users::LoginUser
    field :create_user, mutation: Mutations::Users::Create
    field :update_user, mutation: Mutations::Users::Update
    field :destroy_user, mutation: Mutations::Users::Destroy
    field :activate_user, mutation: Mutations::Users::Activate
    field :request_user_password, mutation: Mutations::Users::RequestUserPassword
    field :update_user_password, mutation: Mutations::Users::UpdateUserPassword

    field :add_cart_items, mutation: Mutations::Users::AddCartItems
    field :delete_cart_items, mutation: Mutations::Users::DeleteCartItems
    
    field :create_order, mutation: Mutations::Orders::CreateOrder
  end
end
