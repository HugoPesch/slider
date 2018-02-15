module Slider
  class Upload < ActiveRecord::Base
    
    has_many :orders
    has_many :galleries, :through => :orders

    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, :url=>"/images/:class/:attachment/:id_partition/:style/:filename", default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    validates :image_file_name, uniqueness: {case_sensitive: false}

  end
end
