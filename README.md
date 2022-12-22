# E Commerce API

## Features
### Completed
- Shopping Cart

### In Progress
- User Login

### To-Do
- User Orders 
- Admin Dashboard 

## Dependencies
- ruby 3.0.4
- rails 7.0.4 
- graphql
- pg 1.1
- puma 6.0.0
- rack-cors 
- bcrypt 
- figaro
 
### Testing Packages
- faker
- factory_bot_rails
- capybara 
- rspec-rails 
- pry 
- shoulda-matchers

## Database Architecture 
| User |
| ----------- |
| has_one :cart |
| has_many :orders |
| role { member, admin }|

| Cart |
| ----------- |
| belongs_to :user |
| has_many :cart_items |
| has_many :color_size_items, through: => :cart_items |

| Category | 
| ----------- |
| has_many :items |
| role { hardgoods, softgoods } |
- Modify your category roles based on the different types of Goods your store will be selling.
- For the e commerce site this example was designed for, Shrimp Republic, the store sells wood signs and clothing, therefore the material used to make the product reflect the roles for the Category.

| Item |
| ----------- |
| belongs_to :category |
| has_many :item_size_colors |
| has_many :sizes, through: => :item_size_colors |
| has_many :colors, through: => :item_size_colors |
| subcategory { shirts, hats, hoodies, signs, coasters } |
- Modify your subcategories based on the different goods your store is selling.

| Size | 
| ----------- |
| has_many :item_size_colors |
| has_many :items, :through => :item_size_colors | 
| has_many :colors, :through => :item_size_colors | 

| Color |
| ----------- |
| has_many :item_size_colors |
| has_many :items, :through => :item_size_colors |
| has_many :sizes, :through => :item_size_colors |

| ItemSizeColor |
| ----------- |
| has_many :order_items |
| has_many :orders, :through => :order_items |
| has_many :cart_items |
| has_many :carts, :through => :cart_items |
| belongs_to :item |
| belongs_to :size |
| belongs_to :color |
- A many-to-many-to-many relationship between Item, Size & Color is achieved to keep stock of the Items inventory when users select different Colors and Sizes

| CartItem |
| ----------- |
| belongs_to :cart |
| belongs_to :item_size_color |
- CartItem model is relational to ItemSizeColor model to keep Stock of Items inventory for different sizes and colors of the same item.

| Order |
| ----------- |
| belongs_to :user |
| has_many :order_items |
| has_many :item_size_colors, :through => :order_items |
| status { placed, shipped, delivered, inquiry, refunded, returned_and_refunded, canceled } |
- Status of inquiry means a customer has reached out in regards to an issue with an order that has already been delivered.

| OrderItem |
| ----------- |
| belongs_to :order |
| belongs_to :item_size_color |
- Similar to CartItem model, we relate the OrderItem model to ItemSizeColor model to keep stock of items inventory for different sizes and colors of the same item.

## GraphQL Requests
### Mutations 
#### Users
- addCartItems </br>
`addCartItems(input: {
   userId: "#{user_id}",
   itemSizeColorId: "#{item_size_color_id}",
   quantity: "#{quantity}"}
 ) {
   user{ 
     id
     firstName
     lastName 
     cart {
       id
       cartItems {
         id
         quantity
         itemSizeColor {
           id
           stock
           item {
             id
             name 
             price
           }
           color {
             id
             name 
           }
           size {
             id 
             name
           }
         }
       }
     }
   }
 }`</br>
- deleteCartItems</br>
`deleteCartItems(
   input: {
   cartItemId: "#{cart_item_id}",
   quantity: "#{quantity}" 
 }) {
   user {
     id 
     cart {
       id
       cartItems {
         id
         quantity
       }
     }
   }
 }`</br>
### Queries
#### Items 
- allItems </br>
`allItems {
  name
  price
  discount
  stock
  description
  category {
    role 
    title
  }}`</br>
- findItem</br>
`findItem(id: "#{id}") {
  id 
  name 
  description
  stock 
  price 
  discount
  category {
    title 
    role
  }
 }`</br>
- findItemsBySubcategory </br>
`findItemsBySubcategory(
  role: "#{role}",
  subcategory: "#{subcategory}"
) {
  id 
  name 
  description 
  stock 
  price 
  discount 
  category {
    id 
    title 
    role 
  }
}`</br>
- findItems</br>
`findItems(role: "#{role}") {
 id 
 name 
 description 
 stock 
 price 
 discount 
 category {
   id 
   title 
   role 
 }
}`</br>
#### Users
- findUser
- findCart

## Testing Suite
**Command Line Instructions**
- `bundle install`
- `rails db:{create,migrate,seed}`
- `bundle exec rspec`


