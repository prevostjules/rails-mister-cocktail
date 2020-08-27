class Api::V1::CocktailsController < Api::V1::BaseController

  def index
    @cocktails = Cocktail.all
  end
end
