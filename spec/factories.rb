FactoryBot.define do 
  factory :category do 
    role { rand(0..1) }
    title { Faker::Fantasy::Tolkien.character }
  end 

  factory :item do 
    name { Faker::Name.first_name }
    description { Faker::ChuckNorris.fact }
    stock { rand(1..200) }
    price { rand(20..350) }
    discount { rand(1..50) }
    color { Faker::Fantasy::Tolkien.race }
    material { Faker::Fantasy::Tolkien.poem }
    category { nil } 
    images { Faker::Fantasy::Tolkien.location }
  end 
end 