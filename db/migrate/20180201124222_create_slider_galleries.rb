class CreateSliderGalleries < ActiveRecord::Migration
  def change
    create_table :slider_galleries do |t|

      t.belongs_to :carrousel, index: true
      t.text :galleryName

      t.timestamps

    end
  end
end
