
class Slider < ApplicationRecord
  has_one :images_sliders
  has_many :images, througt: :image_slider
end
