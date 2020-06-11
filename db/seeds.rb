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

("a".."t").each do |letter|
  url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
  user_serialized = open(url).read
  user = JSON.parse(user_serialized)
  drinks = user["drinks"]

  drinks.each do |drink|
    name = drink["strDrink"]
    img_url = drink["strDrinkThumb"]
    i = 1
    str_ingredient = "strIngredient#{i}"
    str_measure = "strMeasure#{i}"
    ingredients = []
    measures = []
    until drink[str_ingredient].nil?
      ingredient = drink[str_ingredient]
      ingredients << ingredient
      measure = drink[str_measure]
      measures << measure
      i += 1
      str_ingredient = "strIngredient#{i}"
      str_measure = "strMeasure#{i}"
    end
    cocktail = Cocktail.new(name: name, img_url: img_url)
      j = 0
      ingredients.each do |ingredient|
        dose = Dose.new(description: measures[j])
        if dose.description.nil?
        else
          ingredient_exist = Ingredient.where(name: ingredient)[0]
          if ingredient_exist.nil?
            j += 1
          else
            dose.ingredient = ingredient_exist
            dose.cocktail = cocktail
            if dose.valid?
              dose.save!
              j += 1
            else
              j += 1
            end

          end
        end
      end
  end
end


puts "Finished"
