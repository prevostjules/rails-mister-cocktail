# json.extract! @cocktails.first, :name
#   json.messages do
#     json.text 'Ouech'
#   end

  # json.text do
  #   json.text 'ouech'
  # end

texts = ["a", "b"]

json.messages do
  json.array! texts do
    json.text "Premier cocktail"
    json.text "Deuxième cocktail"
  end
end
