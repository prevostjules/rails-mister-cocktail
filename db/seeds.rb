# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'


puts "Destroy current cocktails in DB"

Cocktail.destroy_all

puts "Destroy current ingredients in DB"

Ingredient.destroy_all
Dose.destroy_all


puts "Create ingredients"

a = Ingredient.new(name: "lemon")
a.save!
b = Ingredient.new(name: "ice")
b.save!
c = Ingredient.new(name: "mint leaves")
c.save!

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
user_serialized = open(url).read
user = JSON.parse(user_serialized)
ingredients = user["drinks"]
ingredients.each do |ingredient|
    new_ingredient = Ingredient.new(name: ingredient.values[0])
    new_ingredient.save!
  end

mary = Cocktail.new(name: "Bloody Mary")
mary.save!
gr = Dose.new(description: "3 grammes")
gr.ingredient = a
gr.cocktail = mary
gr.save!

henry = Cocktail.new(name: "Bloody Henry")
henry.save!
feuilles = Dose.new(description: "3 feuilles")
feuilles.ingredient = b
feuilles.cocktail = henry
feuilles.save!

george = Cocktail.create(name: "Bloody George")
george.save!
pounds = Dose.new(description: "3 pounds")
pounds.ingredient = b
pounds.cocktail = george
pounds.save!


puts "Finished"
