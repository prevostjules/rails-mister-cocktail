class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo
  validates :photo, presence: true, if: :no_img_url?
  validates :name, presence: true, uniqueness: true

  private

  def no_img_url?
    self.img_url.nil?
  end

end
