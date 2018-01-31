class CreateTableGalleries < ActiveRecord::Migration
  def change
    create_table :slider_galleries do |t|
      t.belongs_to :slider_carrousel, index: true, foreign_key: true
      t.text :galleryName
      t.timestamps
    end
  end
end
