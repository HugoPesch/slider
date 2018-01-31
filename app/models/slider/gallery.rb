module Slider
  class Gallery < ActiveRecord::Base
    belongs_to  :slider_carrousel
    has_many :images

    validates :galleryName,  presence: true, allow_blank: false,
    uniqueness: {case_sensitive: false}

  end
end
