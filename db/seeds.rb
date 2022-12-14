# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
softgoods = Category.create(role: 0, title: "Soft Goods")
hardgoods = Category.create(role: 1, title: "Hard Goods")

item0 = Item.create(
  category_id: softgoods.id,
  name: "Deep Fried Grouper Throats",
  description: "Custom designed Red Grouper Logo on the front left pocket, 
  same larger image on the back.",
  stock: 10,
  price: 25.00,
  discount: 0.00,
  material: "100% Cotton",
  color: "White"
)

item1 = Item.create(
  category_id: softgoods.id,
  name: "Shrimp Republic Logo Tee",
  description: "Classic flyfishing shrimp logo t shirt.",
  stock: 10,
  price: 25.00,
  discount: 0.00,
  material: "100% Cotton",
  color: "Yellow"
)

item2 = Item.create(
  category_id: softgoods.id,
  name: "Tribal Wahoo",
  description: "Tribal Wahoo Tshirt",
  stock: 10,
  price: 25.00,
  discount: 0.00,
  material: "100% Cotton",
  color: "Light Blue"
)
