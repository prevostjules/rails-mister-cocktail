# json.extract! @cocktails.first, :name
#   json.messages do
#     json.text 'Ouech'
#   end

  # json.text do
  #   json.text 'ouech'
  # end

texts = ["Le tout premier cockatil enregistré sur ce site a pour nom '#{@cocktails.first.name}.'", "Le dernier cockail a avoir été créé sur ce site a pour nom '#{@cocktails.last.name}.'"]

json.messages do
  json.array! texts do |text|
    json.text text
  end
end
