class CreateSliderCarrousels < ActiveRecord::Migration
  def change
    create_table :slider_carrousels do |t|

      t.text :carrouselName
      t.text :type_slide
      t.text :img_class

    end
  end
end
