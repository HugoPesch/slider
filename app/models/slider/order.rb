module Slider
  class Order < ActiveRecord::Base

    belongs_to :gallery
    belongs_to :upload
    
  end
end
