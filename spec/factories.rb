FactoryBot.define do 
  factory :user do 
    role { 0 }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Name.first_name + rand(0..1234).to_s + "@example.com"}
    password_digest { Faker::Creature::Animal.name.gsub(" ", "") + rand(0..1233).to_s}
  end 
  factory :cart do 
    user { nil }
    
  end 
  factory :category do 
    role { rand(0..1) }
    title { Faker::Fantasy::Tolkien.character }
  end 

  factory :size do 
    name { ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'].sample }
  end 

  factory :color do 
    name { Faker::Fantasy::Tolkien.race }
  end 

  factory :item do 
    name { Faker::Name.first_name }
    description { Faker::ChuckNorris.fact }
    price { rand(20..350) }
    discount { 0.00 }
    material { [Faker::Fantasy::Tolkien.poem] }
    category { nil } 
    images { [Faker::Fantasy::Tolkien.location] }
    subcategory { rand(0..4) }
  end 
  
  factory :item_size_color do 
    item { nil }
    color { nil }
    size { nil }
    stock { rand(1..100) }
  end 
  
  factory :cart_item do 
    item_size_color { nil }
    cart { nil }
    quantity { rand(1..2) } 
  end 
end 