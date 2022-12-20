FactoryBot.define do 
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
    stock { rand(1..200) }
    price { rand(20..350) }
    discount { rand(1..50) }
    material { [Faker::Fantasy::Tolkien.poem] }
    category { nil } 
    images { [Faker::Fantasy::Tolkien.location] }
    subcategory { rand(0..4) }
  end 
  
  factory :item_size_color do 
    item { nil }
    color { nil }
    size { nil }
    quantity { rand(1..100) }
  end 
end 