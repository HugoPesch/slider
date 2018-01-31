class AddTypeSlideToSliderCarrousels < ActiveRecord::Migration
  def change
    add_column :slider_carrousels, :type_slide, :text
  end
end
