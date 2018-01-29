class Images_slider < ApplicationRecord
  belongs_to  :slider
  has_many :images
end
