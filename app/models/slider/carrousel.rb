module Slider
  class Carrousel < ActiveRecord::Base
    has_one :gallery
    has_many :uploads, :through  => :gallery
  end
end
