# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all

User.create!(first_name:  "Denise",
              last_name:  "Owner",
             email: "denise@thebestrestaurant.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

10.times do |n|
  first_name  = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = "#{first_name}_#{n+1}@gmail.org"
  password = "#{first_name}password"
  User.create!(first_name:  first_name,
                last_name: last_name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Meal.create(
  name: "Beef and Broccoli",
  price: 7.95,
  description: "Beef and broccoli stir fried in
  a delicious garlic sauce",
  calorie_count: 550,
  category: "Main"
)

Meal.create(
  name: "Chicken and Broccoli",
  price: 8.95,
  description: "Chicken and broccoli stir fried in
  a delicious garlic sauce",
  calorie_count: 550,
  category: "Main"
)

Meal.create(
  name: "Mashed Potatoes",
  price: 5.95,
  description: "Organically grown red potatoes pureed
    with garlic and sour cream and drizzled in a delicious
    brown gravy",
  calorie_count: 775,
  category: "Side"
)

Meal.create(
  name: "Steamed Vegetables",
  price: 5.95,
  description: "Organically grown vegetable medley
  steamed to perfection",
  calorie_count: 250,
  category: "Side"
)

Meal.create(
  name: "Red Wine",
  price: 10.95,
  description: "Delicious red wine from the Bordeaux Region",
  calorie_count: 775,
  category: "Drink"
)

Meal.create(
  name: "Chocolate Lava Cake",
  price: 8.00,
  description: "Delicious chocolate cake with warm and
    decadent center",
  calorie_count: 600,
  category: "Dessert"
)
