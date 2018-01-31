module Slider
  class Carrousel < ActiveRecord::Base
    has_one :gallery
    has_many :images, :through  => :gallery
  end
end
