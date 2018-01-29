class CreateTableImagesSliders < ActiveRecord::Migration
  def change
    create_table :slider_images_carrousels do |t|
      t.belongs_to :slider_carrousel, index: true, foreign_key: true
      t.integer :numIS
      t.timestamps
    end
  end
end
