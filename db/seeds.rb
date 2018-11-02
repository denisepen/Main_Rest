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
             email: "owner@restaurant.com",
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

# :title, :comment, :date_posted, :user_id

Review.create(
  title: "Love This Place",
  comment: "I love to bring the family here",
  date_posted: DateTime.new(2018,2,3),
  user_id: 2
)

Review.create(
  title: "Service a Little Slow",
  comment: "Foods great but service is slow",
  date_posted: DateTime.new(2018,4,8),
  user_id: 3
)

Review.create(
  title: "Alot of Variety",
  comment: "From burgers to trout, this place has it all",
  date_posted: DateTime.new(2018,9,21),
  user_id: 5
)

Meal.create(
  name: "Cheese Burger",
  price: 10.95,
  description: "Cheeseburger with lettuce, tomatoes, onions, and pickles",
  calorie_count: 750,
  category: "Main"
)

Meal.create(
  name: "Baked Trout",
  price: 15.95,
  description: "Trout filet baked in white wine with lemons, garlic, and rosemary",
  calorie_count: 375,
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
  name: "Beef and Broccoli",
  price: 7.95,
  description: "Beef and broccoli stir fried in
  a delicious garlic sauce",
  calorie_count: 550,
  category: "Main"
)

Meal.create(
  name: "Chocolate Lava Cake",
  price: 8.00,
  description: "Delicious chocolate cake with warm and
    decadent center",
  calorie_count: 600,
  category: "Dessert"
)

Meal.create(
  name: "Strawbery Cheese Cake",
  price: 7.75,
  description: "A slice of delcious cheese cake combined with strawberry puree",
  calorie_count: 600,
  category: "Dessert"
)

Meal.create(
  name: "Vanilla Ice Cream",
  price: 5.00,
  description: "Two scoops of vanilla ice cream",
  calorie_count: 425,
  category: "Dessert"
)

Meal.create(
  name: "House Salad",
  price: 6.00,
  description: "Salad with romaine lettuce, cherry tomatoes, sliced cucumbers and your choice of dressing.",
  calorie_count: 450,
  category: "Side"
)

Meal.create(
  name: "Caesar Salad",
  price: 7.95,
  description: "Delicious caesar salad",
  calorie_count: 450,
  category: "Side"
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
  name: "Coke",
  price: 2.95,
  description: "Coca Cola",
  calorie_count: 400,
  category: "Drink"
)

Meal.create(
  name: "Bottled Water",
  price: 4.95,
  description: "Evian Spring Water",
  calorie_count: 100,
  category: "Drink"
)
