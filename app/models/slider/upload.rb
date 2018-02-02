module Slider
  class Upload < ActiveRecord::Base

    belongs_to :slider_gallery

    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    validates :image_file_name, uniqueness: {case_sensitive: false}

  end
end
