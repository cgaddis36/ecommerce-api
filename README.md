# E Commerce API

## Features
### Completed
- Shopping Cart

### In Progress
- User Login
- User Orders 

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

| Cart | Item |
| ----------- | ----------- |
| belongs_to :user | belongs_to :category |
| has_many :cart_items | has_many :item_size_colors |
| has_many :color_size_items, through: => :cart_items | has_many :sizes, through: => :item_size_colors |
| | has_many :colors, through: => :item_size_colors |

| Size | Color |
| ----------- | ----------- |
| has_many :item_size_colors | has_many :item_size_colors |
| has_many :items, :through => :item_size_colors | has_many :items, :through => :item_size_colors |
| has_many :colors, :through => :item_size_colors | has_many :sizes, :through => :item_size_colors |
