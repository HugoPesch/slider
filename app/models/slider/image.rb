module Slider
  class Image < ActiveRecord::Base
    belongs_to  :slider_images_carrousel
  end
end
