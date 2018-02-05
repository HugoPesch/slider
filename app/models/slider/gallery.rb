module Slider
  class Gallery < ActiveRecord::Base

    belongs_to :carrousel
    has_many :uploads

    validates :galleryName,  presence: true, allow_blank: false,
    uniqueness: {case_sensitive: false}
  end
end
