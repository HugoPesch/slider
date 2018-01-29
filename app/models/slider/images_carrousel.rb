module Slider
  class Images_carrousel < ActiveRecord::Base
    belongs_to  :slider_carrousel
    has_many :images
  end
end
