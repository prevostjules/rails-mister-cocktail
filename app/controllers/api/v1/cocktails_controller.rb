class Api::V1::CocktailsController < Api::V1::BaseController

  def index
    @cocktails = Cocktail.all
    @messages = {text: "ouech", text: "ouech"}

  end
end
