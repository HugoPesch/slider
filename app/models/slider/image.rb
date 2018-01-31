module Slider
  class Image < ActiveRecord::Base
    belongs_to  :gallery
  end
end
