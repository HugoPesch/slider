module Slider
  class Carrousel < ActiveRecord::Base
    has_one :gallery
    has_many :uploads, :through => :account

    validates :carrouselName, presence: true, allow_blank: false,
    uniqueness: {case_sensitive: false}

    validates :type_slide,presence: true

  end
end
