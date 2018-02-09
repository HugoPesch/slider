class AddSlidersToGalleries < ActiveRecord::Migration
  def change
    add_foreign_key :slider_galleries, :slider_carrousels, column: :carrousel_id
  end
end
