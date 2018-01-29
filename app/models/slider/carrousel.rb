module Slider
  class Carrousel < ActiveRecord::Base
    has_one :slider_images_carrousel
    has_many :images, :through  => :slider_images_carrousel
  end
end
