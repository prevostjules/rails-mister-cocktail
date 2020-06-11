class DosesController < ApplicationController
  before_action :set_cocktail, only: [ :new, :create, :destroy ]

  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(set_params)
    @ingredient = Ingredient.find(params[:dose][:ingredient_id])
    @dose.ingredient = @ingredient
    @dose.cocktail = @cocktail
    if @dose.valid?
      @dose.save!
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def set_params
    params.require(:dose).permit(:description, :ingredient)
  end
end
