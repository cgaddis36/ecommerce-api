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
  name: "Deep Fried Grouper Tee",
  description: "Custom designed Red Grouper Logo on the front left pocket, 
  same larger image on the back.",
  price: 25.00,
  discount: 0.00,
  material: ["100% Cotton"],
)

item1 = Item.create(
  category_id: softgoods.id,
  name: "OG Shrimp Tee",
  description: "Classic fly fishing shrimp logo T-shirt. The original Shrimp Republic design with a Black Fly fishing shrimp logo on the front left pocket and the same larger image centered on the back.", 
  price: 25.00,
  discount: 0.00,
  material: ["100% Cotton"],
)

item2 = Item.create(
  category_id: softgoods.id,
  name: "Tribal Wahoo Tee",
  description: "Tribal Wahoo T-shirt design including the fiery underbelly of this salt laden design. Small Wahoo logo on the front, with same image larger on the back.",
  price: 25.00,
  discount: 0.00,
  material: ["100% Cotton"],
)

item3 = Item.create(
  category_id: softgoods.id,
  name: "Band of Shrimps Tee",
  description: "Fly fishing shrimp circle logo on the front, band of shrimp on the back.",
  price: 25.00,
  discount: 0.00,
  material: ["100% Cotton"]
)

item4 = Item.create(
  category_id: softgoods.id,
  name: "Republic of West Florida Tee",
  description: "Classic fly fishing shrimp logo on the front, Republic of West Florida shrimp playing the guitar on the back.",
  price: 25.00,
  discount: 0.00,
  material: ["100% Cotton"]
)

item5 = Item.create(
  category_id: hardgoods.id,
  name: "Destin Sign",
  description: "Handmade wooden sign made from wood gathered on the beach in Northwest Florida. Sanded, carved, stained, painted and then coated with resin.",
  price: 60.00,
  discount: 0.00,
  material: ["Pine"]
)

item6 = Item.create(
  category_id: hardgoods.id,
  name: "Republic of West Florida Sign",
  description: "Handmade wooden sign made from wood gathered on the beach in Northwest Florida. Sanded, carved, stained, painted and then coated with resin.",
  price: 60.00,
  discount: 0.00,
  material: ["Pecky Cypress"],
  subcategory: 3
)

item5 = Item.create(
  category_id: hardgoods.id,
  name: "Sailfish Sign",
  description: "Handmade wooden sign made from wood gathered on the beach in Northwest Florida. Sanded, carved, stained, painted and then coated with resin.",
  price: 60.00,
  discount: 0.00,
  material: ["Pine"],
  subcategory: 3
)

item6 = Item.create(
  category_id: hardgoods.id,
  name: "Coral Fin Tuna",
  description: "Handmade wooden sign made from wood gathered on the beach in Northwest Florida. Sanded, carved, stained, painted and then coated with resin.",
  price: 60.00,
  discount: 0.00,
  material: ["Pecky Cypress"],
  subcategory: 3
)